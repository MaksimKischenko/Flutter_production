import 'dart:async';
import 'dart:math' as math;


import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';





/// Allows to externally control [WebPaginatedTableCustom] state
/// and trigger actions such as changing page number or size. Instatiate an object,
/// keep it somewhere (e.g. parent widgets state or static field/top level variable),
/// pass it to [WebPaginatedTableCustom.controller] via constructor and you're ready to go.
/// Please note that there're a few properties that allow to fetch internal state
/// value's (such as rows per page), those values can't be fetched until the
/// controller is attached - this happens during the first call to the build()
/// method of [WebPaginatedTableCustom].
/// The controller extends [ChangeNotifier] in order to let consumers know
/// if there're changes to [WebPaginatedTableCustom] state. E.g. you can hide
/// standard paginator of [WebPaginatedTableCustom] and simplement your own
/// paginator as a StatefullWidget, subsribe to controller in order to update
/// the paginator.
class PaginatorController extends ChangeNotifier {
  WebPaginatedTableCustomState? _state;

  // Whenever setState is called within PaginatedDataTable2State and there's
  // an attached controlooer, than this method is called by PaginatedDataTable2State
  void _notifyListeners() {
    notifyListeners();
  }

  bool get isAttached => _state != null;

  void _attach(WebPaginatedTableCustomState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  void _checkAttachedAndThrow() {
    if (_state == null) {
      throw "PaginatorController is not attached to any PaginatedDataTable2 and can't be used";
    }
  }

  void _assertIfNotAttached() {
    assert(_state != null,
        "PaginatorController is not attached to any PaginatedDataTable2 and can't be used");
  }

  /// Returns number of rows displayed in the [WebPaginatedTableCustom]. Throws if no
  /// table is attached to the controller
  int get rowCount {
    _checkAttachedAndThrow();
    return _state!._rowCount;
  }

  /// Returns number of rows displayed in single page of the [WebPaginatedTableCustom].
  /// Throws if no table is attached to the controller
  int get rowsPerPage {
    _checkAttachedAndThrow();
    return _state!._effectiveRowsPerPage;
  }

  /// Returns the index of the first (topmost) row displayed currently displayed in [WebPaginatedTableCustom].
  /// Throws if no table is attached to the controller
  int get currentRowIndex {
    _checkAttachedAndThrow();
    return _state!._firstRowIndex;
  }

  /// Сhange page size and set the number of rows in a single page
  void setRowsPerPage(int rowsPerPage) {
    _assertIfNotAttached();
    _state?._setRowsPerPage(rowsPerPage);
  }

  /// Show rows from the next page
  void goToNextPage() {
    _assertIfNotAttached();
    if (_state != null) {
      if (_state!._isNextPageUnavailable()) return;
      _state!._handleNext();
    }
  }

  /// Show rows from the previous page
  void goToPreviousPage() {
    _assertIfNotAttached();
    _state?._handlePrevious();
  }

  /// Fast forward to the very first page/row
  void goToFirstPage() {
    _assertIfNotAttached();
    _state?._handleFirst();
  }

  /// Fast forward to the very last page/row
  void goToLastPage() {
    _assertIfNotAttached();
    _state?._handleLast();
  }

  /// Switch the page so that he given row is displayed at the top. I.e. it
  /// is possible to have pages start at arbitrary rows, not at the boundaries
  /// of pages as determined by page size.
  void goToRow(int rowIndex) {
    _assertIfNotAttached();
    // if (_state != null) {
    //   _state!.setState(() {
    //     _state!._firstRowIndex =
    //         math.max(math.min(_state!._rowCount - 1, rowIndex), 0);
    //   });
    //}
    _state?.pageTo(rowIndex, false);
  }

  /// Switches to the page where the given row is present.
  /// The row can be in the middle of the page, pages are aligned
  /// to page size. E.g. with page size 5 going to index 6 (rows #7)
  /// will set page starting index at 5 (#6)
  void goToPageWithRow(int rowIndex) {
    _assertIfNotAttached();
    _state?.pageTo(rowIndex);
  }
}

/// The default value for [rowsPerPage].
///
/// Useful when initializing the field that will hold the current
/// [rowsPerPage], when implemented [onRowsPerPageChanged].
const int defaultRowsPerPage = 10;

/// In-place replacement of standard [PaginatedDataTable] widget, mimics it API.
/// Has the header row and paginatior always fixed to top and bottom (correspondingly).
/// Core of the table (with data rows) is scrollable and stretching to max width/height of it's container.
/// You can set minimal width of the table via [minWidth] property and Flex behavior of
/// table core via [fit] property.
/// By using [DataColumn2] instead of [DataColumn] it is possible to control
/// relative column sizes (setting them to S, M and L). [DataRow2] provides
/// row-level tap event handlers.
/// See also:
///
///  * [DataTable2], which is not paginated.
class WebPaginatedTableCustom extends StatefulWidget {
  /// Check out [PaginatedDataTable] for the API decription.
  /// Key differences are [minWidth] and [fit] properties.
  WebPaginatedTableCustom({
    super.key,
    this.header,
    this.actions,
    required this.columns,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.sortArrowAnimationDuration = const Duration(milliseconds: 150),
    this.sortArrowIcon = Icons.arrow_upward,
    this.onSelectAll,
    this.dataRowHeight = kMinInteractiveDimension,
    this.headingRowHeight = 56.0,
    this.headingRowColor,
    this.horizontalMargin = 24.0,
    this.columnSpacing = 56.0,
    this.dividerThickness,
    this.renderEmptyRowsInTheEnd = true,
    this.fixedLeftColumns = 0,
    this.fixedTopRows = 1,
    this.fixedColumnsColor,
    this.fixedCornerColor,
    this.showCheckboxColumn = true,
    this.showFirstLastButtons = false,
    this.initialFirstRowIndex = 0,
    this.onPageChanged,
    this.rowsPerPage = defaultRowsPerPage,
    this.availableRowsPerPage = const <int>[
      defaultRowsPerPage,
      defaultRowsPerPage * 2,
      defaultRowsPerPage * 5,
      defaultRowsPerPage * 10
    ],
    this.onRowsPerPageChanged,
    this.dragStartBehavior = DragStartBehavior.start,
    required this.source,
    this.checkboxHorizontalMargin,
    this.wrapInCard = true,
    this.minWidth,
    this.fit = FlexFit.tight,
    this.hidePaginator = false,
    this.controller,
    this.scrollController,
    this.empty,
    this.border,
    this.autoRowsToHeight = false,
    this.smRatio = 0.67,
    this.lmRatio = 1.2,
  })  : assert(actions == null || (header != null)),
        assert(columns.isNotEmpty),
        assert(sortColumnIndex == null ||
            (sortColumnIndex >= 0 && sortColumnIndex < columns.length)),
        assert(rowsPerPage > 0),
        assert(() {
          if (onRowsPerPageChanged != null && autoRowsToHeight == false) {
            assert(availableRowsPerPage.contains(rowsPerPage));
          }
          return true;
        }());

  final bool wrapInCard;

  /// The table card's optional header.
  ///
  /// This is typically a [Text] widget, but can also be a [Row] of
  /// [TextButton]s. To show icon buttons at the top end side of the table with
  /// a header, set the [actions] property.
  ///
  /// If items in the table are selectable, then, when the selection is not
  /// empty, the header is replaced by a count of the selected items. The
  /// [actions] are still visible when items are selected.
  final Widget? header;

  /// Icon buttons to show at the top end side of the table. The [header] must
  /// not be null to show the actions.
  ///
  /// Typically, the exact actions included in this list will vary based on
  /// whether any rows are selected or not.
  ///
  /// These should be size 24.0 with default padding (8.0).
  final List<Widget>? actions;

  /// The configuration and labels for the columns in the table.
  final List<DataColumn> columns;

  /// The current primary sort key's column.
  ///
  /// See [DataTable.sortColumnIndex].
  final int? sortColumnIndex;

  /// Whether the column mentioned in [sortColumnIndex], if any, is sorted
  /// in ascending order.
  ///
  /// See [DataTable.sortAscending].
  final bool sortAscending;

  /// When changing sort direction an arrow icon in the header is rotated clockwise.
  /// The value defines the duration of the rotation animation.
  /// If not set, the default animation duration is 150 ms.
  final Duration sortArrowAnimationDuration;

  /// Icon to be displayed when sorting is applied to a column.
  /// If not set, the default icon is [Icons.arrow_upward]
  final IconData sortArrowIcon;

  /// Invoked when the user selects or unselects every row, using the
  /// checkbox in the heading row.
  ///
  /// See [DataTable.onSelectAll].
  final ValueSetter<bool?>? onSelectAll;

  /// The height of each row (excluding the row that contains column headings).
  ///
  /// This value is optional and defaults to kMinInteractiveDimension if not
  /// specified.
  final double dataRowHeight;

  /// The height of the heading row.
  ///
  /// This value is optional and defaults to 56.0 if not specified.
  final double headingRowHeight;

  /// {@template flutter.material.dataTable.headingRowColor}
  /// The background color for the heading row.
  ///
  /// The effective background color can be made to depend on the
  /// [MaterialState] state, i.e. if the row is pressed, hovered, focused when
  /// sorted. The color is painted as an overlay to the row. To make sure that
  /// the row's [InkWell] is visible (when pressed, hovered and focused), it is
  /// recommended to use a translucent color.
  /// {@endtemplate}
  ///
  /// If null, [DataTableThemeData.headingRowColor] is used.
  ///
  /// {@template flutter.material.DataTable.headingRowColor}
  /// ```dart
  /// PaginatedDataTable2(
  ///   headingRowColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
  ///     if (states.contains(MaterialState.hovered))
  ///       return Theme.of(context).colorScheme.primary.withOpacity(0.08);
  ///     return null;  // Use the default value.
  ///   }),
  /// )
  /// ```
  ///
  /// See also:
  ///
  ///  * The Material Design specification for overlay colors and how they
  ///    match a component's state:
  ///    <https://material.io/design/interaction/states.html#anatomy>.
  /// {@endtemplate}
  final MaterialStateProperty<Color?>? headingRowColor;

  /// The horizontal margin between the edges of the table and the content
  /// in the first and last cells of each row.
  ///
  /// When a checkbox is displayed, it is also the margin between the checkbox
  /// the content in the first data column.
  ///
  /// This value defaults to 24.0 to adhere to the Material Design specifications.
  ///
  /// If [checkboxHorizontalMargin] is null, then [horizontalMargin] is also the
  /// margin between the edge of the table and the checkbox, as well as the
  /// margin between the checkbox and the content in the first data column.
  final double horizontalMargin;

  /// The horizontal margin between the contents of each data column.
  ///
  /// This value defaults to 56.0 to adhere to the Material Design specifications.
  final double columnSpacing;

  /// {@macro flutter.material.dataTable.showCheckboxColumn}
  final bool showCheckboxColumn;

  /// Flag to display the pagination buttons to go to the first and last pages.
  final bool showFirstLastButtons;

  /// The index of the first row to display when the widget is first created.
  final int? initialFirstRowIndex;

  /// Flag to render empty(invisible) rows in the end of the table when there is
  /// a fixed number of [rowsPerPage] and the number of visible rows is smaller
  /// This value defaults to true
  final bool renderEmptyRowsInTheEnd;

  /// The divider thickness between rows.
  final double? dividerThickness;

  /// Invoked when the user switches to another page.
  ///
  /// The value is the index of the first row on the currently displayed page.
  final ValueChanged<int>? onPageChanged;

  /// The number of rows to show on each page.
  ///
  /// See also:
  ///
  ///  * [onRowsPerPageChanged]
  ///  * [defaultRowsPerPage]
  final int rowsPerPage;

  /// The options to offer for the rowsPerPage.
  ///
  /// The current [rowsPerPage] must be a value in this list.
  ///
  /// The values in this list should be sorted in ascending order.
  final List<int> availableRowsPerPage;

  /// Invoked when the user selects a different number of rows per page.
  ///
  /// If this is null, then the value given by [rowsPerPage] will be used
  /// and no affordance will be provided to change the value.
  final ValueChanged<int?>? onRowsPerPageChanged;

  /// The data source which provides data to show in each row. Must be non-null.
  ///
  /// This object should generally have a lifetime longer than the
  /// [WebPaginatedTableCustom] widget itself; it should be reused each time the
  /// [WebPaginatedTableCustom] constructor is called.
  final DataTableSource source;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// Horizontal margin around the checkbox, if it is displayed.
  ///
  /// If null, then [horizontalMargin] is used as the margin between the edge
  /// of the table and the checkbox, as well as the margin between the checkbox
  /// and the content in the first data column. This value defaults to 24.0.
  final double? checkboxHorizontalMargin;

  /// If set, the table will stop shrinking below the threshold and provide
  /// horizontal scrolling. Useful for the cases with narrow screens (e.g. portrait phone orientation)
  /// and lots of columns (that get messed with little space)
  final double? minWidth;

  /// Data rows are wrapped in Flexible widget, this property sets its' fit property.
  /// When ther're few rows it determines if the core
  /// of the table must grow and fill the contrainer (FlexFit.tight - useful if
  /// you want the paginator to stick to the bottom when there're few rows) or
  /// of you want to have the table to take minimal space and do not have bottom
  /// pager stick to the bottom (FlexFit.loose)
  final FlexFit fit;

  /// Set vertical and horizontal borders between cells, as well as outside borders around table.
  /// NOTE: setting this field will disable standard horizontal dividers which are controlled by
  /// themes and [dividerThickness] property
  final TableBorder? border;

  ///If true rows per page is set to fill available height so that no scroll bar is ever displayed.
  ///[rowsPerPage] is ignore when this field is set to true
  final bool autoRowsToHeight;

  /// Placeholder widget which is displayed whenever the data rows are empty.
  /// The widget will be displayed below column
  final Widget? empty;

  /// Determines ratio of Small column's width to Medium column's width.
  /// I.e. 0.5 means that Small column is twice narower than Medium column.
  final double smRatio;

  /// Determines ratio of Large column's width to Medium column's width.
  /// I.e. 2.0 means that Large column is twice wider than Medium column.
  final double lmRatio;

  /// The number of sticky rows fixed at the top of the table.
  /// The heading row is counted/included.
  /// By defult the value is 1 which means header row is fixed.
  /// Set to 0 in order to unstick the header,
  /// set to >1 in order to fix data rows
  /// (i.e. in order to fix both header and the first data row use value of 2)
  final int fixedTopRows;

  /// Number of sticky columns fixed at the left side of the table.
  /// Check box column (if enabled) is also counted
  final int fixedLeftColumns;

  /// Backgound color of the sticky columns fixed via [fixedLeftColumns].
  /// Note: unlike data rows which can change their colors depending on material state (e.g. selected, hovered)
  /// this color is static and doesn't repond to state change
  /// Note: to change background color of fixed data rows use [WebPaginatedTableCustom.headingRowColor] and
  /// individual row colors of data rows provided via [rows]
  final Color? fixedColumnsColor;

  /// Backgound color of the top left corner which is fixed whenere both [fixedTopRows]
  /// and [fixedLeftColumns] are greater than 0
  /// Note: unlike data rows which can change their colors depending on material state (e.g. selected, hovered)
  /// this color is static and doesn't repond to state change
  /// Note: to change background color of fixed data rows use [WebPaginatedTableCustom.headingRowColor] and
  /// individual row colors of data rows provided via [rows]
  final Color? fixedCornerColor;

  /// Hides the paginator at the bottom. Can be useful in case you decide create
  /// your own paginator and control the widget via [WebPaginatedTableCustom.controller]
  final bool hidePaginator;

  /// Used to comntrol widget's state externally and trigger actions. See
  /// [PaginatorController]
  final PaginatorController? controller;

  /// Exposes scroll controller of the SingleChildScrollView that makes data rows vertically scrollable
  final ScrollController? scrollController;

  @override
  WebPaginatedTableCustomState createState() => WebPaginatedTableCustomState();
}

/// Holds the state of a [WebPaginatedTableCustom].
///
/// The table can be programmatically paged using the [pageTo] method.
class WebPaginatedTableCustomState extends State<WebPaginatedTableCustom> {
  late int _firstRowIndex;
  late int _rowCount;
  late bool _rowCountApproximate;
  int _selectedRowCount = 0;
  final Map<int, DataRow?> _rows = <int, DataRow?>{};
  int _effectiveRowsPerPage = -1;
  int _prevRowsPerPageForAutoRows = -1;

  @override
  void setState(VoidCallback fn) {
    // Notifying listeners in the next message queue pass
    // Doing that in the current call somehow messes with update
    // lifecycle when using async table
    if (widget.controller != null) {
      Future.delayed(const Duration(milliseconds: 0),
          () => widget.controller?._notifyListeners());
    }
    //widget.controller?._notifyListeners();
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    _firstRowIndex = PageStorage.of(context).readState(context) as int? ??
        widget.initialFirstRowIndex ??
        0;
    widget.source.addListener(_handleDataSourceChanged);
    _effectiveRowsPerPage = widget.rowsPerPage;
    widget.controller?._attach(this);
    _handleDataSourceChanged();
  }

  @override
  void didUpdateWidget(WebPaginatedTableCustom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.source != widget.source) {
      oldWidget.source.removeListener(_handleDataSourceChanged);
      widget.source.addListener(_handleDataSourceChanged);
      _handleDataSourceChanged();
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach();
      widget.controller?._attach(this);
    }
  }

  @override
  void dispose() {
    widget.source.removeListener(_handleDataSourceChanged);
    super.dispose();
  }

  void _handleDataSourceChanged() {
    setState(() {
      _rowCount = widget.source.rowCount;
      _rowCountApproximate = widget.source.isRowCountApproximate;
      _selectedRowCount = widget.source.selectedRowCount;
      _rows.clear();
    });
  }

  // Aligns row index to page size returning the first index of a page
  // that contains given row
  int _alignRowIndex(int rowIndex, int rowsPerPage) => ((rowIndex + 1) ~/ rowsPerPage) * rowsPerPage;

  /// Ensures that the given row is visible. [align] params makes sure that
  /// starting index will be aligned to page size, e.g. if page size is 5, row with
  /// index 7 (ordinal number 8) is requested, rather than showing rows 8 - 12
  /// starting page at row 7 it will make first row index 5 displaying 6-10
  void pageTo(int rowIndex, [bool align = true]) {
    final oldFirstRowIndex = _firstRowIndex;
    setState(() {
      _firstRowIndex = align
          ? _alignRowIndex(rowIndex, _effectiveRowsPerPage)
          : math.max(math.min(_rowCount - 1, rowIndex), 0);
    });
    if ((widget.onPageChanged != null) &&
        (oldFirstRowIndex != _firstRowIndex)) {
      widget.onPageChanged!(_firstRowIndex);
    }
  }

  DataRow _getBlankRowFor(int index) => DataRow.byIndex(
      index: index,
      cells: widget.columns
          .map<DataCell>((DataColumn column) => DataCell.empty)
          .toList(),
    );

  DataRow _getProgressIndicatorRowFor(int index) {
    var haveProgressIndicator = false;
    final cells =
        widget.columns.map<DataCell>((DataColumn column) {
      if (!column.numeric) {
        haveProgressIndicator = true;
        return const DataCell(CircularProgressIndicator());
      }
      return DataCell.empty;
    }).toList();
    if (!haveProgressIndicator) {
      haveProgressIndicator = true;
      cells[0] = const DataCell(CircularProgressIndicator());
    }
    return DataRow.byIndex(
      index: index,
      cells: cells,
    );
  }

  // Flag to be used by AsyncDataTable to show empty table when loading data
  // ignore: prefer_final_fields
  bool _showNothing = false;

  List<DataRow> _getRows(int firstRowIndex, int rowsPerPage) {
    final result = <DataRow>[];

    if ((widget.empty != null && widget.source.rowCount < 1) || _showNothing) {
      return result;
    } // If empty placeholder is provided - don't create blank rows

    final nextPageFirstRowIndex = firstRowIndex + rowsPerPage;
    var haveProgressIndicator = false;

    for (var index = firstRowIndex; index < nextPageFirstRowIndex; index += 1) {
      DataRow? row;
      if (index < _rowCount || _rowCountApproximate) {
        row = _rows.putIfAbsent(index, () => widget.source.getRow(index));
        if (row == null && !haveProgressIndicator) {
          row ??= _getProgressIndicatorRowFor(index);
          haveProgressIndicator = true;
        }
      }
      // It won't render empty rows if renderEmptyRowsInTheEnd is set to false
      if (row == null) {
        if (widget.renderEmptyRowsInTheEnd) {
          row ??= _getBlankRowFor(index);
          result.add(row);
        }
      } else {
        result.add(row);
      }
    }
    return result;
  }

  void _handleFirst() {
    pageTo(0);
  }

  void _handlePrevious() {
    pageTo(math.max(_firstRowIndex - _effectiveRowsPerPage, 0));
  }

  void _handleNext() {
    pageTo(_firstRowIndex + _effectiveRowsPerPage);
  }

  void _handleLast() {
    pageTo(((_rowCount - 1) / _effectiveRowsPerPage).floor() *
        _effectiveRowsPerPage);
  }

  bool _isNextPageUnavailable() =>
      !_rowCountApproximate &&
      (_firstRowIndex + _effectiveRowsPerPage >= _rowCount);

  final GlobalKey _tableKey = GlobalKey();

  Widget _getHeader() {
    final localizations =
        MaterialLocalizations.of(context);
    final themeData = Theme.of(context);
    var startPadding = widget.horizontalMargin;
    final headerWidgets = <Widget>[];

    if (_selectedRowCount == 0 && widget.header != null) {
      headerWidgets.add(Expanded(child: widget.header!));
      if (widget.header is ButtonBar) {
        // We adjust the padding when a button bar is present, because the
        // ButtonBar introduces 2 pixels of outside padding, plus 2 pixels
        // around each button on each side, and the button itself will have 8
        // pixels internally on each side, yet we want the left edge of the
        // inside of the button to line up with the 24.0 left inset.
        startPadding = 12.0;
      }
    } else if (widget.header != null) {
      headerWidgets.add(Expanded(
        child: Text(localizations.selectedRowCountTitle(_selectedRowCount)),
      ));
    }
    if (widget.actions != null) {
      headerWidgets.addAll(widget.actions!.map<Widget>((Widget action) => Padding(
          // 8.0 is the default padding of an icon button
          padding: const EdgeInsetsDirectional.only(start: 24.0 - 8.0 * 2.0),
          child: action,
        )).toList());
    }

    return Semantics(
      container: true,
      child: DefaultTextStyle(
        // These typographic styles aren't quite the regular ones. We pick the closest ones from the regular
        // list and then tweak them appropriately.
        // See https://material.io/design/components/data-tables.html#tables-within-cards
        style: _selectedRowCount > 0
            ? themeData.textTheme.titleMedium!
                .copyWith(color: themeData.colorScheme.secondary)
            : themeData.textTheme.titleLarge!
                .copyWith(fontWeight: FontWeight.w400),
        child: IconTheme.merge(
          data: const IconThemeData(opacity: 0.54),
          child: Ink(
            height: 64,
            color:
                _selectedRowCount > 0 ? themeData.secondaryHeaderColor : null,
            child: Padding(
              padding:
                  EdgeInsetsDirectional.only(start: startPadding, end: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: headerWidgets,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTable(BoxConstraints constraints) => Flexible(
      fit: widget.fit,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: constraints.minWidth),
        child: DataTable2(
          key: _tableKey,
          columns: widget.columns,
          sortColumnIndex: widget.sortColumnIndex,
          sortAscending: widget.sortAscending,
          sortArrowIcon: widget.sortArrowIcon,
          sortArrowAnimationDuration: widget.sortArrowAnimationDuration,
          onSelectAll: widget.onSelectAll,
          // Make sure no decoration is set on the DataTable
          // from the theme, as its already wrapped in a Card.
          decoration: const BoxDecoration(),
          dividerThickness: widget.dividerThickness,
          fixedLeftColumns: widget.fixedLeftColumns,
          fixedTopRows: widget.fixedTopRows,
          fixedColumnsColor: widget.fixedColumnsColor,
          fixedCornerColor: widget.fixedCornerColor,
          dataRowHeight: widget.dataRowHeight,
          headingRowColor: widget.headingRowColor,
          headingRowHeight: widget.headingRowHeight,
          horizontalMargin: widget.horizontalMargin,
          checkboxHorizontalMargin: widget.checkboxHorizontalMargin,
          columnSpacing: widget.columnSpacing,
          showCheckboxColumn: widget.showCheckboxColumn,
          showBottomBorder: true,
          rows: _getRows(_firstRowIndex, _effectiveRowsPerPage),
          minWidth: widget.minWidth,
          scrollController: widget.scrollController,
          empty: _showNothing ? null : widget.empty,
          border: widget.border,
          smRatio: widget.smRatio,
          lmRatio: widget.lmRatio,
        ),
      ),
    );

  Widget _getFooter() {
    final localizations =
        MaterialLocalizations.of(context);
    final themeData = Theme.of(context);
    final footerTextStyle = themeData.textTheme.bodySmall;
    final footerWidgets = <Widget>[];
  
    
    if (widget.onRowsPerPageChanged != null) {
      final List<Widget> availableRowsPerPage = widget.availableRowsPerPage
          .where((int value) =>
              value <= _rowCount || value == _effectiveRowsPerPage)
          .map<DropdownMenuItem<int>>((int value) => DropdownMenuItem<int>(
          value: value,
          child: Text('$value'),
        )).toList();
      if (!widget.autoRowsToHeight) {
        footerWidgets.addAll(<Widget>[
          Container(
              width:
                  14), // to match trailing padding in case we overflow and end up scrolling
          Text(localizations.rowsPerPageTitle),
          ConstrainedBox(
            constraints: const BoxConstraints(
                minWidth: 64), // 40.0 for the text, 24.0 for the icon
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  items: availableRowsPerPage.cast<DropdownMenuItem<int>>(),
                  value: _effectiveRowsPerPage,
                  onChanged: _setRowsPerPage,
                  style: footerTextStyle,
                  iconSize: 24,
                ),
              ),
            ),
          ),
        ]);
      }
   }

    var lastRow = _firstRowIndex + _effectiveRowsPerPage;

    if (!widget.renderEmptyRowsInTheEnd) {
      if (_firstRowIndex + _effectiveRowsPerPage > _rowCount) {
        lastRow = _rowCount;
      }
    }

    footerWidgets.addAll([
      //Container(width: 32),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          localizations.pageRowsInfoTitle(
            _firstRowIndex + 1,
            lastRow,
            _rowCount,
            _rowCountApproximate,
          ),
        ),
      ),
      Container(width: 32),
      if (widget.showFirstLastButtons)
        IconButton(
          splashRadius: 1, 
          icon: const Icon(Icons.skip_previous),
          padding: EdgeInsets.zero,
          tooltip: localizations.firstPageTooltip,
          onPressed: _firstRowIndex <= 0 ? null : _handleFirst,
          color: AppStyles.colorDark3,
        ),
      IconButton(
        splashRadius: 1,
        icon: const Icon(Icons.chevron_left),
        padding: EdgeInsets.zero,
        tooltip: localizations.previousPageTooltip,
        onPressed: _firstRowIndex <= 0 ? null : _handlePrevious,
        color: AppStyles.colorDark3,
      ),
      Container(width: 24),
      IconButton(
        splashRadius: 1, 
        icon: const Icon(Icons.chevron_right),
        padding: EdgeInsets.zero,
        tooltip: localizations.nextPageTooltip,
        onPressed: _isNextPageUnavailable() ? null : _handleNext,
        color: AppStyles.colorDark3,
      ),
      if (widget.showFirstLastButtons)
        IconButton(
          splashRadius: 1, 
          icon: const Icon(Icons.skip_next),
          padding: EdgeInsets.zero,
          tooltip: localizations.lastPageTooltip,
          onPressed: _isNextPageUnavailable() ? null : _handleLast,
          color: AppStyles.colorDark3,
        ),
      Container(width: 14),
    ]);

    return DefaultTextStyle(
      style: footerTextStyle!,
      child: IconTheme.merge(
        data: const IconThemeData(opacity: 0.54),
        child: SizedBox(
          height: 32,
          child: SingleChildScrollView(
            dragStartBehavior: widget.dragStartBehavior,
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
              children: footerWidgets 
            ),
          ),
        ),
      ),
    );
  }

  void _setRowsPerPage(int? r, [bool wrapInSetState = true]) {
    if (r != null) {
      f() {
        _effectiveRowsPerPage = r;
        if (widget.onRowsPerPageChanged != null) {
          widget.onRowsPerPageChanged!(r);
        }
      }

      if (wrapInSetState) {
        setState(f);
      } else {
        f();
      }
    }
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isHeaderPresent = widget.header != null || widget.actions != null;
        if (widget.autoRowsToHeight) {
          _effectiveRowsPerPage = math.max(
              ((constraints.maxHeight -
                          widget.headingRowHeight -
                          8 * (widget.wrapInCard ? 1 : 0) // card paddings
                          -
                          64 * (isHeaderPresent ? 1 : 0) //header
                          -
                          56 * (widget.hidePaginator ? 0 : 1) // footer
                      ) /
                      widget.dataRowHeight)
                  .floor(),
              1);
          if (_prevRowsPerPageForAutoRows != _effectiveRowsPerPage) {
            //if (prevRowsPerPageForAutoRows != -1)
            // Also call it on the first build to let clients know
            // how many rows were autocalculated
            //widget.onRowsPerPageChanged?.call(_effectiveRowsPerPage);
            _setRowsPerPage(_effectiveRowsPerPage, false);
            // don't call setState here to avoid assertion
            // The following assertion was thrown building LayoutBuilder:
            // setState() or markNeedsBuild() called during build.
            _prevRowsPerPageForAutoRows = _effectiveRowsPerPage;
          }
        }
        assert(debugCheckHasMaterialLocalizations(context));

        // CARD

        Widget t = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isHeaderPresent) _getHeader(),
            _getTable(constraints),
            if (!widget.hidePaginator) _getFooter(),
          ],
        );

        if (widget.wrapInCard) t = Card(semanticContainer: false, child: t);

        return t;
      },
    );
}

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Copyright 2021 Maxim Saplin - changes and modifications to original Flutter implementation of DataTable


bool dataTableShowLogs = true;

/// Relative size of a column determines the share of total table width allocated
/// to each individual column. When determining column widths ratios between S, M and L
/// columns are kept (i.e. Large columns are set to 1.2x width of Medium ones)
/// - see [DataTable2.smRatio], [DataTable2.lmRatio] and same properties on [PaginatedDataTable2].
/// Default S/M ratio is 0.67,L/M ratio is 1.2
enum ColumnSize { S, M, L }

/// Extension of stock [DataColumn], adds the capability to set relative column
/// size via [size] property
@immutable
class DataColumn2 extends DataColumn {
  /// Creates the configuration for a column of a [DataTable2].
  ///
  /// The [label] argument must not be null.
  const DataColumn2(
      {required super.label,
      super.tooltip,
      super.numeric = false,
      super.onSort,
      this.size = ColumnSize.M,
      this.fixedWidth});

  /// Column sizes are determined based on available width by distributing it
  /// to individual columns accounting for their relative sizes (see [ColumnSize])
  final ColumnSize size;

  /// Defines absolute width of the column in pixel (as opposed to relative size used by default).
  /// Warning, if the width happens to be larger than available total width other
  /// columns can be clipped
  final double? fixedWidth;
}

/// Extension of standard [DataRow], adds row level tap events. Also there're
/// onSecondaryTap and onSecondaryTapDown which are not available in DataCells and
/// which can be useful in Desktop settings when a reaction to the right click is required.
@immutable
class DataRow2 extends DataRow {
  //DataRow2.fromDataRow(DataRow row) : this.cells = row.cells;

  /// Creates the configuration for a row of a [DataTable2].
  ///
  /// The [cells] argument must not be null.
  const DataRow2(
      {super.key,
      super.selected = false,
      super.onSelectChanged,
      super.color,
      required super.cells,
      this.specificRowHeight,
      this.onTap,
      this.onDoubleTap,
      super.onLongPress,
      this.onSecondaryTap,
      this.onSecondaryTapDown});

  DataRow2.byIndex(
      {int? index,
      super.selected = false,
      super.onSelectChanged,
      super.color,
      required super.cells,
      this.specificRowHeight,
      this.onTap,
      this.onDoubleTap,
      super.onLongPress,
      this.onSecondaryTap,
      this.onSecondaryTapDown})
      : super.byIndex(index: index);

  /// Specific row height, which will be used only if provided.
  /// If not provided, dataRowHeight will be applied.
  final double? specificRowHeight;

  /// Row tap handler, won't be called if tapped cell has any tap event handlers
  final GestureTapCallback? onTap;

  /// Row right click handler, won't be called if tapped cell has any tap event handlers
  final GestureTapCallback? onSecondaryTap;

  /// Row right mouse down handler, won't be called if tapped cell has any tap event handlers
  final GestureTapDownCallback? onSecondaryTapDown;

  /// Row double tap handler, won't be called if tapped cell has any tap event handlers
  final GestureTapCallback? onDoubleTap;

  // /// Row long press handler, won't be called if tapped cell has any tap event handlers
  // final GestureLongPressCallback? onLongPress;
}

/// In-place replacement of standard [DataTable] widget, mimics it API.
/// Has the header row always fixed and core of the table (with data rows)
/// scrollable and stretching to max width/height of it's container.
/// By using [DataColumn2] instead of [DataColumn] it is possible to control
/// relative column sizes (setting them to S, M and L). [DataRow2] provides
/// row-level tap event handlers.
class DataTable2 extends DataTable {
  DataTable2({
    super.key,
    required super.columns,
    super.sortColumnIndex,
    super.sortAscending = true,
    super.onSelectAll,
    super.decoration,
    super.dataRowColor,
    super.dataRowHeight,
    super.dataTextStyle,
    super.headingRowColor,
    this.fixedColumnsColor,
    this.fixedCornerColor,
    super.headingRowHeight,
    super.headingTextStyle,
    super.horizontalMargin,
    super.checkboxHorizontalMargin,
    this.bottomMargin,
    super.columnSpacing,
    super.showCheckboxColumn = true,
    super.showBottomBorder = false,
    super.dividerThickness,
    this.minWidth,
    this.scrollController,
    this.empty,
    this.border,
    this.smRatio = 0.67,
    this.fixedTopRows = 1,
    this.fixedLeftColumns = 0,
    this.lmRatio = 1.2,
    this.sortArrowAnimationDuration = const Duration(milliseconds: 150),
    this.sortArrowIcon = Icons.arrow_upward,
    required super.rows,
  })  : assert(fixedLeftColumns >= 0),
        assert(fixedTopRows >= 0) {
    // // Fix for #111, syncrhonize scroll position for left fixed column with core
    // // Works fine if there's scrollCongtroller provided externally, allows to avoid jumping
    // _leftColumnVerticalContoller = ScrollController(
    //     initialScrollOffset: _coreVerticalController.positions.isNotEmpty
    //         ? _coreVerticalController.offset
    //         : 0.0);
  }

  static final LocalKey _headingRowKey = UniqueKey();

  void _handleSelectAll(bool? checked, bool someChecked) {
    // If some checkboxes are checked, all checkboxes are selected. Otherwise,
    // use the new checked value but default to false if it's null.
    final effectiveChecked = someChecked || (checked ?? false);
    if (onSelectAll != null) {
      onSelectAll!(effectiveChecked);
    } else {
      for (final row in rows) {
        if (row.onSelectChanged != null && row.selected != effectiveChecked) {
          row.onSelectChanged!(effectiveChecked);
        }
      }
    }
  }

  /// The default height of the heading row.
  static const double _headingRowHeight = 56;

  /// The default horizontal margin between the edges of the table and the content
  /// in the first and last cells of each row.
  static const double _horizontalMargin = 24;

  /// The default horizontal margin between the contents of each data column.
  static const double _columnSpacing = 56;

  /// The default padding between the heading content and sort arrow.
  static const double _sortArrowPadding = 2;

  /// The default divider thickness.
  static const double _dividerThickness = 1;

  /// When changing sort direction an arrow icon in the header is rotated clockwise.
  /// The value defines the duration of the rotation animation.
  /// If not set, the default animation duration is 150 ms.
  final Duration sortArrowAnimationDuration;

  /// Icon to be displayed when sorting is applied to a column.
  /// If not set, the default icon is [Icons.arrow_upward]
  final IconData sortArrowIcon;

  /// If set, the table will stop shrinking below the threshold and provide
  /// horizontal scrolling. Useful for the cases with narrow screens (e.g. portrait phone orientation)
  /// and lots of columns (that get messed with little space)
  final double? minWidth;

  /// If set the table will have empty space added after the the last row and allow scroll the
  /// core of the table higher (e.g. if you would like to have iOS navigation UI at the bottom overlapping the table and
  /// have the ability to slightly scroll up the bototm row to avoid the obstruction)
  final double? bottomMargin;

  /// Exposes scroll controller of the SingleChildScrollView that makes data rows vertically scrollable
  final ScrollController? scrollController;

  /// Placeholder widget which is displayed whenever the data rows are empty.
  /// The widget will be displayed below column
  final Widget? empty;

  /// Set vertical and horizontal borders between cells, as well as outside borders around table.
  @override
  // keep field in order to keep doc
  // ignore: overridden_fields
  final TableBorder? border;

  /// Determines ratio of Small column's width to Medium column's width.
  /// I.e. 0.5 means that Small column is twice narower than Medium column.
  final double smRatio;

  /// Determines ratio of Large column's width to Medium column's width.
  /// I.e. 2.0 means that Large column is twice wider than Medium column.
  final double lmRatio;

  /// The number of sticky rows fixed at the top of the table.
  /// The heading row is counted/included.
  /// By defult the value is 1 which means header row is fixed.
  /// Set to 0 in order to unstick the header,
  /// set to >1 in order to fix data rows
  /// (i.e. in order to fix both header and the first data row use value of 2)
  final int fixedTopRows;

  /// Number of sticky columns fixed at the left side of the table.
  /// Check box column (if enabled) is also counted
  final int fixedLeftColumns;

  /// Backgound color of the sticky columns fixed via [fixedLeftColumns].
  /// Note: unlike data rows which can change their colors depending on material state (e.g. selected, hovered)
  /// this color is static and doesn't repond to state change
  /// Note: to change background color of fixed data rows use [DataTable2.headingRowColor]
  final Color? fixedColumnsColor;

  /// Backgound color of the top left corner which is fixed whenere both [fixedTopRows]
  /// and [fixedLeftColumns] are greater than 0
  /// Note: unlike data rows which can change their colors depending on material state (e.g. selected, hovered)
  /// this color is static and doesn't repond to state change
  /// Note: to change background color of fixed data rows use [DataTable2.headingRowColor]
  final Color? fixedCornerColor;

  Widget _buildCheckbox(
      {required BuildContext context,
      required bool? checked,
      required VoidCallback? onRowTap,
      required ValueChanged<bool?>? onCheckboxChanged,
      required MaterialStateProperty<Color?>? overlayColor,
      required bool tristate,
      required double rowHeight}) {
    final themeData = Theme.of(context);
    final effectiveHorizontalMargin = horizontalMargin ??
        themeData.dataTableTheme.horizontalMargin ??
        _horizontalMargin;

    Widget contents = Semantics(
      container: true,
      child: Container(
        height: rowHeight,
        padding: EdgeInsetsDirectional.only(
          start: checkboxHorizontalMargin ?? effectiveHorizontalMargin,
          end: (checkboxHorizontalMargin ?? effectiveHorizontalMargin) / 2.0,
        ),
        child: Center(
          child: Checkbox(
            value: checked,
            onChanged: onCheckboxChanged,
            tristate: tristate,
          ),
        ),
      ),
    );
    if (onRowTap != null) {
      contents = TableRowInkWell(
        onTap: onRowTap,
        overlayColor: overlayColor,
        child: contents,
      );
    }

    return contents;
  }

  Widget _buildHeadingCell(
      {required BuildContext context,
      required EdgeInsetsGeometry padding,
      required Widget label,
      required String? tooltip,
      required bool numeric,
      required VoidCallback? onSort,
      required bool sorted,
      required bool ascending,
      required double effectiveHeadingRowHeight,
      required MaterialStateProperty<Color?>? overlayColor}) {
    final themeData = Theme.of(context);
    label = Row(
      textDirection: numeric ? TextDirection.rtl : null,
      children: <Widget>[
        Flexible(child: label),
        if (onSort != null) ...<Widget>[
          _SortArrow(
            visible: sorted,
            up: sorted ? ascending : null,
            duration: sortArrowAnimationDuration,
            sortArrowIcon: sortArrowIcon,
          ),
          const SizedBox(width: _sortArrowPadding),
        ],
      ],
    );

    final effectiveHeadingTextStyle = headingTextStyle ??
        themeData.dataTableTheme.headingTextStyle ??
        themeData.textTheme.titleSmall!;

    label = Container(
      padding: padding,
      height: effectiveHeadingRowHeight,
      alignment:
          numeric ? Alignment.centerRight : AlignmentDirectional.centerStart,
      child: AnimatedDefaultTextStyle(
        style: effectiveHeadingTextStyle,
        softWrap: false,
        duration: sortArrowAnimationDuration,
        child: label,
      ),
    );
    if (tooltip != null) {
      label = Tooltip(
        message: tooltip,
        child: label,
      );
    }

    label = InkWell(
      onTap: onSort,
      overlayColor: overlayColor,
      child: label,
    );
    return label;
  }

  Widget _buildDataCell(
      {required BuildContext context,
      required EdgeInsetsGeometry padding,
      required double? specificRowHeight,
      required Widget label,
      required bool numeric,
      required bool placeholder,
      required bool showEditIcon,
      required double defaultDataRowHeight,
      required GestureTapCallback? onTap,
      required GestureTapCallback? onDoubleTap,
      required GestureLongPressCallback? onLongPress,
      required GestureTapDownCallback? onTapDown,
      required GestureTapCancelCallback? onTapCancel,
      required GestureTapCallback? onRowTap,
      required GestureTapCallback? onRowDoubleTap,
      required GestureLongPressCallback? onRowLongPress,
      required GestureTapCallback? onRowSecondaryTap,
      required GestureTapDownCallback? onRowSecondaryTapDown,
      required VoidCallback? onSelectChanged,
      required MaterialStateProperty<Color?>? overlayColor}) {
    final themeData = Theme.of(context);
    if (showEditIcon) {
      const Widget icon = Icon(Icons.edit, size: 18.0);
      label = Expanded(child: label);
      label = Row(
        textDirection: numeric ? TextDirection.rtl : null,
        children: <Widget>[label, icon],
      );
    }

    final effectiveDataTextStyle = dataTextStyle ??
        themeData.dataTableTheme.dataTextStyle ??
        themeData.textTheme.bodyMedium!;
    final effectiveDataRowHeight =
        specificRowHeight ?? defaultDataRowHeight;

    label = Container(
      padding: padding,
      height: effectiveDataRowHeight,
      alignment:
          numeric ? Alignment.centerRight : AlignmentDirectional.centerStart,
      child: DefaultTextStyle(
        style: effectiveDataTextStyle.copyWith(
          color: placeholder
              ? effectiveDataTextStyle.color!.withOpacity(0.6)
              : null,
        ),
        child: DropdownButtonHideUnderline(child: label),
      ),
    );

    // Wrap label intro InkResponse if there're cell or row level tap events
    if (onTap != null ||
        onDoubleTap != null ||
        onLongPress != null ||
        onTapDown != null ||
        onTapCancel != null) {
      // cell only
      label = InkWell(
        onTap: () {
          onTap?.call();
          onRowTap?.call();
        },
        onDoubleTap: () {
          onDoubleTap?.call();
          onRowDoubleTap?.call();
        },
        onLongPress: () {
          onLongPress?.call();
          onRowLongPress?.call();
        },
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        overlayColor: overlayColor,
        child: label,
      );
      label =
          _addSecondaryTaps(onRowSecondaryTap, onRowSecondaryTapDown, label);
    } else if (onSelectChanged != null ||
        onRowTap != null ||
        onRowDoubleTap != null ||
        onRowLongPress != null ||
        onRowSecondaryTap != null ||
        onRowSecondaryTapDown != null) {
      label = TableRowInkWell(
        onTap: onRowTap ?? onSelectChanged,
        onDoubleTap: onRowDoubleTap,
        onLongPress: onRowLongPress,
        overlayColor: overlayColor,
        child: label,
      );

      label =
          _addSecondaryTaps(onRowSecondaryTap, onRowSecondaryTapDown, label);
    }
    return label;
  }

  Widget _addSecondaryTaps(GestureTapCallback? onRowSecondaryTap,
      GestureTapDownCallback? onRowSecondaryTapDown, Widget label) {
    if (onRowSecondaryTap != null || onRowSecondaryTapDown != null) {
      label = GestureDetector(
          onSecondaryTap: onRowSecondaryTap,
          onSecondaryTapDown: onRowSecondaryTapDown,
          child: label);
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    final sw = Stopwatch();
    sw.start();
    // assert(!_debugInteractive || debugCheckHasMaterial(context));
    assert(debugCheckHasMaterial(context));

    final theme = Theme.of(context);
    final effectiveHeadingRowColor =
        headingRowColor ?? theme.dataTableTheme.headingRowColor;
    final effectiveDataRowColor =
        dataRowColor ?? theme.dataTableTheme.dataRowColor;
    final defaultRowColor = MaterialStateProperty.resolveWith(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return theme.colorScheme.primary.withOpacity(0.08);
        }
        return null;
      },
    );
    final anyRowSelectable =
        rows.any((DataRow row) => row.onSelectChanged != null);
    final displayCheckboxColumn = showCheckboxColumn && anyRowSelectable;
    final rowsWithCheckbox = displayCheckboxColumn
        ? rows.where((DataRow row) => row.onSelectChanged != null)
        : <DataRow2>[];
    final rowsChecked = rowsWithCheckbox.where((DataRow row) => row.selected);
    final allChecked =
        displayCheckboxColumn && rowsChecked.length == rowsWithCheckbox.length;
    final anyChecked = displayCheckboxColumn && rowsChecked.isNotEmpty;
    final someChecked = anyChecked && !allChecked;
    final effectiveHorizontalMargin = horizontalMargin ??
        theme.dataTableTheme.horizontalMargin ??
        _horizontalMargin;
    final effectiveColumnSpacing =
        columnSpacing ?? theme.dataTableTheme.columnSpacing ?? _columnSpacing;

    final effectiveHeadingRowHeight = headingRowHeight ??
        theme.dataTableTheme.headingRowHeight ??
        _headingRowHeight;

    final defaultDataRowHeight = dataRowHeight ??
        theme.dataTableTheme.dataRowHeight ??
        kMinInteractiveDimension;

    final tableColumnWidths = List<TableColumnWidth>.filled(
        columns.length + (displayCheckboxColumn ? 1 : 0),
        const _NullTableColumnWidth());

    final headingRow = _buildHeadingRow(
        context, theme, effectiveHeadingRowColor, tableColumnWidths.length);

    final actualFixedRows =
        math.max(0, rows.isEmpty ? 0 : math.min(fixedTopRows, rows.length + 1));
    final actualFixedColumns = math.max(
        0,
        rows.isEmpty
            ? 0
            : math.min(fixedLeftColumns,
                columns.length + (showCheckboxColumn ? 1 : 0)));

    final coreRows = rows.isEmpty ||
            actualFixedColumns >= columns.length + (showCheckboxColumn ? 1 : 0)
        ? null
        : _buildTableRows(
            anyRowSelectable,
            effectiveDataRowColor,
            context,
            theme,
            tableColumnWidths.length - actualFixedColumns,
            defaultRowColor,
            actualFixedRows == 0
                ? _buildHeadingRow(context, theme, effectiveHeadingRowColor,
                    tableColumnWidths.length - actualFixedColumns)
                : null,
            actualFixedRows > 0 ? actualFixedRows - 1 : 0);

    final fixedColumnsRows = rows.isEmpty
        ? null
        : actualFixedColumns > 0
            ? (actualFixedRows < 1
                ? [
                    _buildHeadingRow(
                        context,
                        theme,
                        fixedColumnsColor != null
                            ? MaterialStatePropertyAll(fixedColumnsColor)
                            : effectiveHeadingRowColor,
                        actualFixedColumns),
                    ..._buildTableRows(
                        anyRowSelectable,
                        fixedColumnsColor != null
                            ? MaterialStatePropertyAll(fixedColumnsColor)
                            : effectiveDataRowColor,
                        context,
                        theme,
                        actualFixedColumns,
                        defaultRowColor,
                        null,
                        0,
                        0,
                        true)
                  ]
                : _buildTableRows(
                    anyRowSelectable,
                    fixedColumnsColor != null
                        ? MaterialStatePropertyAll(fixedColumnsColor)
                        : effectiveDataRowColor,
                    context,
                    theme,
                    actualFixedColumns,
                    defaultRowColor,
                    null,
                    actualFixedRows - 1,
                    0,
                    true))
            : null;

    final fixedRows = actualFixedRows > 0
        ? (actualFixedRows == 1
            ? [
                _buildHeadingRow(
                    context,
                    theme,
                    headingRowColor ?? effectiveHeadingRowColor,
                    tableColumnWidths.length - actualFixedColumns)
              ]
            : [
                _buildHeadingRow(
                    context,
                    theme,
                    headingRowColor ?? effectiveHeadingRowColor,
                    tableColumnWidths.length - actualFixedColumns),
                ..._buildTableRows(
                    anyRowSelectable,
                    headingRowColor ?? effectiveDataRowColor,
                    context,
                    theme,
                    tableColumnWidths.length - actualFixedColumns,
                    defaultRowColor,
                    null,
                    0,
                    actualFixedRows - 1,
                    true)
              ])
        : null;

    final fixedCornerRows =
        actualFixedColumns > 0 && actualFixedRows > 0
            ? (actualFixedRows == 1
                ? [
                    _buildHeadingRow(
                        context,
                        theme,
                        fixedCornerColor != null
                            ? MaterialStatePropertyAll(fixedCornerColor)
                            : effectiveHeadingRowColor,
                        actualFixedColumns)
                  ]
                : [
                    _buildHeadingRow(
                        context,
                        theme,
                        fixedCornerColor != null
                            ? MaterialStatePropertyAll(fixedCornerColor)
                            : effectiveHeadingRowColor,
                        actualFixedColumns),
                    ..._buildTableRows(
                        anyRowSelectable,
                        fixedCornerColor != null
                            ? MaterialStatePropertyAll(fixedCornerColor)
                            : effectiveDataRowColor,
                        context,
                        theme,
                        actualFixedColumns,
                        defaultRowColor,
                        null,
                        0,
                        actualFixedRows - 1,
                        true)
                  ])
            : null;

    final checkBoxWidth = _addCheckBoxes(
        displayCheckboxColumn,
        effectiveHorizontalMargin,
        tableColumnWidths,
        headingRow,
        effectiveHeadingRowHeight,
        context,
        someChecked,
        allChecked,
        coreRows,
        fixedRows,
        fixedCornerRows,
        fixedColumnsRows,
        rows,
        actualFixedRows,
        defaultDataRowHeight,
        effectiveDataRowColor);

    final builder = LayoutBuilder(builder: (context, constraints) => SyncedScrollControllers(
          scrollController: scrollController,
          sc12toSc11Position: true,
          builder: (context, sc11, sc12, sc21, sc22) {
            final coreVerticalController = sc11;
            final leftColumnVerticalContoller = sc12;
            final coreHorizontalController = sc21;
            final fixedRowsHorizontalController = sc22;

            var displayColumnIndex = 0;

            // size & build checkboxes in heading and leftmost column
            // to be substracted from total width available to columns

            if (checkBoxWidth > 0) displayColumnIndex += 1;

            // size data columns
            final widths = _calculateDataColumnSizes(
                constraints, checkBoxWidth, effectiveHorizontalMargin);

            // File empty cells in created rows with actual widgets
            for (var dataColumnIndex = 0;
                dataColumnIndex < columns.length;
                dataColumnIndex++) {
              final column = columns[dataColumnIndex];

              final double paddingStart;
              if (dataColumnIndex == 0 && displayCheckboxColumn) {
                paddingStart = effectiveHorizontalMargin / 2.0;
              } else if (dataColumnIndex == 0 && !displayCheckboxColumn) {
                paddingStart = effectiveHorizontalMargin;
              } else {
                paddingStart = effectiveColumnSpacing / 2.0;
              }

              final double paddingEnd;
              if (dataColumnIndex == columns.length - 1) {
                paddingEnd = effectiveHorizontalMargin;
              } else {
                paddingEnd = effectiveColumnSpacing / 2.0;
              }

              final padding = EdgeInsetsDirectional.only(
                start: paddingStart,
                end: paddingEnd,
              );

              tableColumnWidths[displayColumnIndex] =
                  FixedColumnWidth(widths[dataColumnIndex]);

              final h = _buildHeadingCell(
                  context: context,
                  padding: padding,
                  effectiveHeadingRowHeight: effectiveHeadingRowHeight,
                  label: column.label,
                  tooltip: column.tooltip,
                  numeric: column.numeric,
                  onSort: column.onSort != null
                      ? () => column.onSort!(dataColumnIndex,
                          sortColumnIndex != dataColumnIndex || !sortAscending)
                      : null,
                  sorted: dataColumnIndex == sortColumnIndex,
                  ascending: sortAscending,
                  overlayColor: effectiveHeadingRowColor);

              headingRow.children[displayColumnIndex] =
                  h; // heading row alone is used to display table header should there be no data rows

              if (displayColumnIndex < actualFixedColumns) {
                if (actualFixedRows < 1) {
                  fixedColumnsRows![0].children[displayColumnIndex] = h;
                } else if (actualFixedRows > 0) {
                  fixedCornerRows![0].children[displayColumnIndex] = h;
                }
              } else {
                if (actualFixedRows < 1 && coreRows != null) {
                  coreRows[0]
                      .children[displayColumnIndex - actualFixedColumns] = h;
                } else if (actualFixedRows > 0) {
                  fixedRows![0]
                      .children[displayColumnIndex - actualFixedColumns] = h;
                }
              }

              var rowIndex = 0;
              final skipRows = actualFixedRows == 1
                  ? 0
                  : actualFixedRows > 1
                      ? actualFixedRows - 1
                      : -1;

              for (final row in rows) {
                final cell = row.cells[dataColumnIndex];
                //dataRows[rowIndex].children![displayColumnIndex]

                final c = _buildDataCell(
                    context: context,
                    padding: padding,
                    defaultDataRowHeight: defaultDataRowHeight,
                    specificRowHeight:
                        row is DataRow2 ? row.specificRowHeight : null,
                    label: cell.child,
                    numeric: column.numeric,
                    placeholder: cell.placeholder,
                    showEditIcon: cell.showEditIcon,
                    onTap: cell.onTap,
                    onDoubleTap: cell.onDoubleTap,
                    onLongPress: cell.onLongPress,
                    onTapDown: cell.onTapDown,
                    onTapCancel: cell.onTapCancel,
                    onRowTap: row is DataRow2 ? row.onTap : null,
                    onRowDoubleTap: row is DataRow2 ? row.onDoubleTap : null,
                    onRowLongPress: row.onLongPress,
                    onRowSecondaryTap:
                        row is DataRow2 ? row.onSecondaryTap : null,
                    onRowSecondaryTapDown:
                        row is DataRow2 ? row.onSecondaryTapDown : null,
                    onSelectChanged: row.onSelectChanged != null
                        ? () => row.onSelectChanged!(!row.selected)
                        : null,
                    overlayColor: row.color ?? effectiveDataRowColor);

                if (displayColumnIndex < actualFixedColumns) {
                  if (rowIndex + 1 < actualFixedRows) {
                    fixedCornerRows![rowIndex + 1]
                        .children[displayColumnIndex] = c;
                  } else {
                    fixedColumnsRows![rowIndex - skipRows]
                        .children[displayColumnIndex] = c;
                  }
                } else {
                  if (rowIndex + 1 < actualFixedRows) {
                    fixedRows![rowIndex + 1]
                        .children[displayColumnIndex - actualFixedColumns] = c;
                  } else {
                    coreRows![rowIndex - skipRows]
                        .children[displayColumnIndex - actualFixedColumns] = c;
                  }
                }

                rowIndex += 1;
              }
              displayColumnIndex += 1;
            }

            final widthsAsMap = tableColumnWidths.asMap();
            final leftWidthsAsMap = actualFixedColumns > 0
                ? tableColumnWidths.take(actualFixedColumns).toList().asMap()
                : null;
            final rightWidthsAsMap = actualFixedColumns >
                    0
                ? tableColumnWidths.skip(actualFixedColumns).toList().asMap()
                : null;

            bool isRowsEmpty(List<TableRow>? rows) => rows == null || rows.isEmpty || rows[0].children.isEmpty;

            final coreTable = Table(
                columnWidths:
                    actualFixedColumns > 0 ? rightWidthsAsMap : widthsAsMap,
                children: coreRows ?? [],
                border: border == null
                    ? null
                    : isRowsEmpty(fixedRows) && isRowsEmpty(fixedColumnsRows)
                        ? border
                        : !isRowsEmpty(fixedRows) &&
                                !isRowsEmpty(fixedColumnsRows)
                            ? TableBorder(
                                //top: border!.top,
                                //left: border!.left,
                                right: border!.right,
                                bottom: border!.bottom,
                                verticalInside: border!.verticalInside,
                                horizontalInside: border!.horizontalInside,
                                borderRadius: border!.borderRadius)
                            : isRowsEmpty(fixedRows)
                                ? TableBorder(
                                    top: border!.top,
                                    //left: border!.left,
                                    right: border!.right,
                                    bottom: border!.bottom,
                                    verticalInside: border!.verticalInside,
                                    horizontalInside: border!.horizontalInside,
                                    borderRadius: border!.borderRadius)
                                : TableBorder(
                                    //top: border!.top,
                                    left: border!.left,
                                    right: border!.right,
                                    bottom: border!.bottom,
                                    verticalInside: border!.verticalInside,
                                    horizontalInside: border!.horizontalInside,
                                    borderRadius: border!.borderRadius));

            Table? fixedRowsTabel;
            Table? fixedColumnsTable;
            Table? fixedTopLeftCornerTable;
            Widget? fixedColumnAndCornerCol;
            Widget? fixedRowsAndCoreCol;

            if (rows.isNotEmpty) {
              if (fixedRows != null &&
                  !isRowsEmpty(fixedRows) &&
                  actualFixedColumns <
                      columns.length + (showCheckboxColumn ? 1 : 0)) {
                fixedRowsTabel = Table(
                    columnWidths:
                        actualFixedColumns > 0 ? rightWidthsAsMap : widthsAsMap,
                    children: fixedRows,
                    border: border == null
                        ? null
                        : isRowsEmpty(fixedCornerRows)
                            ? border
                            : TableBorder(
                                top: border!.top,
                                //left: border!.left,
                                right: border!.right,
                                bottom: border!.bottom,
                                verticalInside: border!.verticalInside,
                                horizontalInside: border!.horizontalInside,
                                borderRadius: border!.borderRadius));
              }

              if (fixedColumnsRows != null && !isRowsEmpty(fixedColumnsRows)) {
                fixedColumnsTable = Table(
                    columnWidths: leftWidthsAsMap,
                    children: fixedColumnsRows,
                    border: border == null
                        ? null
                        : isRowsEmpty(fixedCornerRows)
                            ? border
                            : TableBorder(
                                //top: border!.top,
                                left: border!.left,
                                right: border!.right,
                                bottom: border!.bottom,
                                verticalInside: border!.verticalInside,
                                horizontalInside: border!.horizontalInside,
                                borderRadius: border!.borderRadius));
              }

              if (fixedCornerRows != null && !isRowsEmpty(fixedCornerRows)) {
                fixedTopLeftCornerTable = Table(
                    columnWidths: leftWidthsAsMap,
                    children: fixedCornerRows,
                    border: border);
              }

              Widget addBottomMargin(Table t) =>
                  bottomMargin != null && bottomMargin! > 0
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [t, SizedBox(height: bottomMargin!)])
                      : t;

              fixedRowsAndCoreCol = Scrollbar(
                  controller: coreHorizontalController,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: SingleChildScrollView(
                            controller: fixedRowsHorizontalController,
                            scrollDirection: Axis.horizontal,
                            child: (fixedRowsTabel != null)
                                ? fixedRowsTabel
                                // WOrkaround for a bug when there's no horizontal scrollbar should there be no this SingleChildScrollView. I.e. originally this part was ommited and not scrollable was added to the column if not fixed top row was visible
                                : SizedBox(
                                    height: 0,
                                    width: widths.fold<double>(
                                        0,
                                        (previousValue, value) =>
                                            previousValue + value),
                                  ))),
                    Flexible(
                        fit: FlexFit.tight,
                        child: SingleChildScrollView(
                            controller: coreVerticalController,
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                                controller: coreHorizontalController,
                                scrollDirection: Axis.horizontal,
                                child: addBottomMargin(coreTable))))
                  ]));

              fixedColumnAndCornerCol = fixedTopLeftCornerTable == null &&
                      fixedColumnsTable == null
                  ? null
                  : Column(mainAxisSize: MainAxisSize.min, children: [
                      if (fixedTopLeftCornerTable != null)
                        fixedTopLeftCornerTable,
                      if (fixedColumnsTable != null)
                        Flexible(
                            fit: FlexFit.loose,
                            child: ScrollConfiguration(
                                behavior: ScrollConfiguration.of(context)
                                    .copyWith(scrollbars: false),
                                child: SingleChildScrollView(
                                    controller: leftColumnVerticalContoller,
                                    scrollDirection: Axis.vertical,
                                    child: addBottomMargin(fixedColumnsTable))))
                    ]);
            }

            final completeWidget = Container(
                decoration: decoration ?? theme.dataTableTheme.decoration,
                child: rows.isEmpty
                    ? Column(children: [
                        SingleChildScrollView(
                            controller: coreHorizontalController,
                            scrollDirection: Axis.horizontal,
                            child: Table(
                                columnWidths: widthsAsMap,
                                border: border,
                                children: [headingRow])),
                        Flexible(
                            fit: FlexFit.tight,
                            child: empty ?? const SizedBox())
                      ])
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (fixedColumnAndCornerCol != null)
                            fixedColumnAndCornerCol,
                          if (fixedRowsAndCoreCol != null)
                            Flexible(
                                fit: FlexFit.tight, child: fixedRowsAndCoreCol)
                        ],
                      ));

            return completeWidget;
          }));

    sw.stop();

    if (dataTableShowLogs && kDebugMode) {
      debugPrint('DataTable2 built: ${sw.elapsedMilliseconds}ms');
    }

    return builder;
  }

  double _addCheckBoxes(
      bool displayCheckboxColumn,
      double effectiveHorizontalMargin,
      List<TableColumnWidth> tableColumns,
      TableRow headingRow,
      double headingHeight,
      BuildContext context,
      bool someChecked,
      bool allChecked,
      List<TableRow>? coreRows,
      List<TableRow>? fixedRows,
      List<TableRow>? fixedCornerRows,
      List<TableRow>? fixedColumnRows,
      List<DataRow> rows,
      int actualFixedRows,
      double defaultDataRowHeight,
      MaterialStateProperty<Color?>? effectiveDataRowColor) {
    double checkBoxWidth = 0;

    if (displayCheckboxColumn) {
      checkBoxWidth = effectiveHorizontalMargin +
          Checkbox.width +
          effectiveHorizontalMargin / 2.0;
      tableColumns[0] = FixedColumnWidth(checkBoxWidth);

      // Create heading twice, in the heading row used as back-up for the case of no data and any of the xxx_rows table
      headingRow.children[0] = _buildCheckbox(
          context: context,
          checked: someChecked ? null : allChecked,
          onRowTap: null,
          onCheckboxChanged: (bool? checked) =>
              _handleSelectAll(checked, someChecked),
          overlayColor: null,
          tristate: true,
          rowHeight: headingHeight);

      if (fixedCornerRows != null) {
        fixedCornerRows[0].children[0] = headingRow.children[0];
      } else if (fixedColumnRows != null) {
        fixedColumnRows[0].children[0] = headingRow.children[0];
      } else if (fixedRows != null) {
        fixedRows[0].children[0] = headingRow.children[0];
      } else {
        coreRows![0].children[0] = headingRow.children[0];
      }

      final skipRows = actualFixedRows == 1
          ? 0
          : actualFixedRows > 1
              ? actualFixedRows - 1
              : -1;

      var rowIndex = 0;
      for (final row in rows) {
        final x = _buildCheckbox(
            context: context,
            checked: row.selected,
            onRowTap: () {
              if (row is DataRow2 && row.onTap != null) {
                row.onTap?.call();
              } else {
                row.onSelectChanged?.call(!row.selected);
              }
            },
            onCheckboxChanged: row.onSelectChanged,
            overlayColor: row.color ?? effectiveDataRowColor,
            tristate: false,
            rowHeight: ((rows[rowIndex] is DataRow2) &&
                    (rows[rowIndex] as DataRow2).specificRowHeight != null)
                ? (rows[rowIndex] as DataRow2).specificRowHeight!
                : defaultDataRowHeight);

        if (fixedCornerRows != null && rowIndex < fixedCornerRows.length - 1) {
          fixedCornerRows[rowIndex + 1].children[0] = x;
        } else if (fixedColumnRows != null) {
          fixedColumnRows[rowIndex - skipRows].children[0] = x;
        } else if (fixedRows != null && rowIndex < fixedRows.length - 1) {
          fixedRows[rowIndex + 1].children[0] = x;
        } else {
          coreRows![rowIndex - skipRows].children[0] = x;
        }

        rowIndex += 1;
      }
    }
    return checkBoxWidth;
  }

  List<double> _calculateDataColumnSizes(BoxConstraints constraints,
      double checkBoxWidth, double effectiveHorizontalMargin) {
    var totalColAvailableWidth = constraints.maxWidth;
    if (minWidth != null && totalColAvailableWidth < minWidth!) {
      totalColAvailableWidth = minWidth!;
    }

    // full margins are added to side column widths when no check box column is
    // present, half-margin added to first data column width is check box column
    // is present and full margin added to the right

    totalColAvailableWidth = totalColAvailableWidth -
        checkBoxWidth -
        effectiveHorizontalMargin -
        (checkBoxWidth > 0
            ? effectiveHorizontalMargin / 2
            : effectiveHorizontalMargin);

    final columnWidth = totalColAvailableWidth / columns.length;
    var totalColCalculatedWidth = 0.0;
    final totalFixedWidth = columns.fold<double>(
        0,
        (previousValue, element) =>
            previousValue +
            (element is DataColumn2 && element.fixedWidth != null
                ? element.fixedWidth!
                : 0.0));

    assert(totalFixedWidth < totalColAvailableWidth,
        'DataTable2, combined width of columns of fixed width is greater than availble parent width. Table will be clipped');

    totalColAvailableWidth =
        math.max(0, totalColAvailableWidth - totalFixedWidth);

    // adjust column sizes relative to S, M, L
    final widths = List<double>.generate(columns.length, (i) {
      var w = columnWidth;
      final column = columns[i];
      if (column is DataColumn2) {
        if (column.fixedWidth != null) {
          w = column.fixedWidth!;
        } else if (column.size == ColumnSize.S) {
          w *= smRatio;
        } else if (column.size == ColumnSize.L) {
          w *= lmRatio;
        }
      }

      // skip fixed width columns
      if (!(column is DataColumn2 && column.fixedWidth != null)) {
        totalColCalculatedWidth += w;
      }
      return w;
    });

    // scale columns to fit the total lemnght into available width

    final ratio = totalColAvailableWidth / totalColCalculatedWidth;
    for (var i = 0; i < widths.length; i++) {
      // skip fixed width column
      if (!(columns[i] is DataColumn2 &&
          (columns[i] as DataColumn2).fixedWidth != null)) {
        widths[i] *= ratio;
      }
    }

    // add margins to side columns
    if (widths.length == 1) {
      widths[0] = math.max(
          0,
          widths[0] +
              effectiveHorizontalMargin +
              (checkBoxWidth > 0
                  ? effectiveHorizontalMargin / 2
                  : effectiveHorizontalMargin));
    } else if (widths.length > 1) {
      widths[0] = math.max(
          0,
          widths[0] +
              (checkBoxWidth > 0
                  ? effectiveHorizontalMargin / 2
                  : effectiveHorizontalMargin));
      widths[widths.length - 1] =
          math.max(0, widths[widths.length - 1] + effectiveHorizontalMargin);
    }
    return widths;
  }

  List<TableRow> _buildTableRows(
      bool anyRowSelectable,
      MaterialStateProperty<Color?>? effectiveDataRowColor,
      BuildContext context,
      ThemeData theme,
      int numberOfCols,
      MaterialStateProperty<Color?> defaultRowColor,
      TableRow? headingRow,
      [int skipRows = 0,
      int takeRows = 0,
      bool forceEffectiveDataRowColor = false]) {
    final rowStartIndex = skipRows;
    final tableRows = List<TableRow>.generate(
      (takeRows <= 0 ? rows.length - skipRows : takeRows) +
          (headingRow == null ? 0 : 1),
      (int index) {
        final actualIndex = headingRow == null ? index : index - 1;
        if (headingRow != null && index == 0) {
          return headingRow;
        } else {
          final isSelected = rows[rowStartIndex + actualIndex].selected;
          final isDisabled = anyRowSelectable &&
              rows[rowStartIndex + actualIndex].onSelectChanged == null;
          final states = <MaterialState>{
            if (isSelected) MaterialState.selected,
            if (isDisabled) MaterialState.disabled,
          };
          final resolvedDataRowColor = (forceEffectiveDataRowColor
                  ? effectiveDataRowColor
                  : (rows[rowStartIndex + actualIndex].color ??
                      effectiveDataRowColor))
              ?.resolve(states);
          final rowColor = resolvedDataRowColor;
          final borderSide = Divider.createBorderSide(
            context,
            width: dividerThickness ??
                theme.dataTableTheme.dividerThickness ??
                _dividerThickness,
          );
          final  border = showBottomBorder
              ? Border(bottom: borderSide)
              : Border(top: borderSide);
          return TableRow(
            key: rows[rowStartIndex + actualIndex].key,
            decoration: BoxDecoration(
              // Changed standard behaviour to never add border should the thickness be 0
              border: dividerThickness == null ||
                      (dividerThickness != null && dividerThickness != 0.0)
                  ? border
                  : null,
              color: rowColor ?? defaultRowColor.resolve(states),
            ),
            children: List<Widget>.filled(
                numberOfCols <= 0 ? numberOfCols : numberOfCols,
                const _NullWidget()),
          );
        }
      },
    );

    return tableRows;
  }

  TableRow _buildHeadingRow(
      BuildContext context,
      ThemeData theme,
      MaterialStateProperty<Color?>? effectiveHeadingRowColor,
      int numberOfCols) {
    final headingRow = TableRow(
      key: _headingRowKey,
      decoration: BoxDecoration(
        // Changed standard behaviour to never add border should the thickness be 0
        border: showBottomBorder &&
                border == null &&
                (dividerThickness == null ||
                    (dividerThickness != null && dividerThickness != 0.0))
            ? Border(
                bottom: Divider.createBorderSide(
                context,
                width: dividerThickness ??
                    theme.dataTableTheme.dividerThickness ??
                    _dividerThickness,
              ))
            : null,
        color: effectiveHeadingRowColor?.resolve(<MaterialState>{}),
      ),
      children: List<Widget>.filled(numberOfCols, const _NullWidget()),
    );
    return headingRow;
  }
}

class _SortArrow extends StatefulWidget {
  const _SortArrow({
    required this.visible,
    required this.up,
    required this.duration,
    required this.sortArrowIcon,
  });

  final bool visible;

  final bool? up;

  final Duration duration;

  final IconData sortArrowIcon;

  @override
  _SortArrowState createState() => _SortArrowState();
}

class _SortArrowState extends State<_SortArrow> with TickerProviderStateMixin {
  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  late AnimationController _orientationController;
  late Animation<double> _orientationAnimation;
  double _orientationOffset = 0;

  bool? _up;

  static final Animatable<double> _turnTween =
      Tween<double>(begin: 0, end: math.pi)
          .chain(CurveTween(curve: Curves.easeIn));

  @override
  void initState() {
    super.initState();
    _up = widget.up;
    _opacityAnimation = CurvedAnimation(
      parent: _opacityController = AnimationController(
        duration: widget.duration,
        vsync: this,
      ),
      curve: Curves.fastOutSlowIn,
    )..addListener(_rebuild);
    _opacityController.value = widget.visible ? 1.0 : 0.0;
    _orientationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _orientationAnimation = _orientationController.drive(_turnTween)
      ..addListener(_rebuild)
      ..addStatusListener(_resetOrientationAnimation);
    if (widget.visible) _orientationOffset = widget.up! ? 0.0 : math.pi;
  }

  void _rebuild() {
    setState(() {
      // The animations changed, so we need to rebuild.
    });
  }

  void _resetOrientationAnimation(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      assert(_orientationAnimation.value == math.pi);
      _orientationOffset += math.pi;
      _orientationController.value = 0.0;
    }
  }

  @override
  void didUpdateWidget(_SortArrow oldWidget) {
    super.didUpdateWidget(oldWidget);
    var skipArrow = false;
    final newUp = widget.up ?? _up;
    if (oldWidget.visible != widget.visible) {
      if (widget.visible &&
          (_opacityController.status == AnimationStatus.dismissed)) {
        _orientationController.stop();
        _orientationController.value = 0.0;
        _orientationOffset = newUp! ? 0.0 : math.pi;
        skipArrow = true;
      }
      if (widget.visible) {
        _opacityController.forward();
      } else {
        _opacityController.reverse();
      }
    }
    if ((_up != newUp) && !skipArrow) {
      if (_orientationController.status == AnimationStatus.dismissed) {
        _orientationController.forward();
      } else {
        _orientationController.reverse();
      }
    }
    _up = newUp;
  }

  @override
  void dispose() {
    _opacityController.dispose();
    _orientationController.dispose();
    super.dispose();
  }

  static const double _arrowIconBaselineOffset = -1.5;
  static const double _arrowIconSize = 16;

  @override
  Widget build(BuildContext context) => Opacity(
      opacity: _opacityAnimation.value,
      child: Transform(
        transform:
            Matrix4.rotationZ(_orientationOffset + _orientationAnimation.value)
              ..setTranslationRaw(0, _arrowIconBaselineOffset, 0),
        alignment: Alignment.center,
        child: Icon(
          widget.sortArrowIcon,
          size: _arrowIconSize,
        ),
      ),
    );
}

// coverage:ignore-start
class _NullTableColumnWidth extends TableColumnWidth {
  const _NullTableColumnWidth();

  @override
  double maxIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) =>
      throw UnimplementedError();

  @override
  double minIntrinsicWidth(Iterable<RenderBox> cells, double containerWidth) =>
      throw UnimplementedError();
}

class _NullWidget extends Widget {
  const _NullWidget();

  @override
  Element createElement() => throw UnimplementedError();
}
// coverage:ignore-end

/// Creates pairs of scroll controllers which can be provided to scrollables and ensure that
/// offset change in one scrollable scroll the second one (and vice a versa)
/// There's a bug (or feature) on iOS with bouncing scroll (when it goes out of range)
/// when scrollable get out of sync while in this bouncing position
class SyncedScrollControllers extends StatefulWidget {
  const SyncedScrollControllers(
      {super.key,
      required this.builder,
      this.scrollController,
      this.sc12toSc11Position = false});

  /// One of the controllers (sc11) won't be created by this widget
  /// but rather use externally provided one
  final ScrollController? scrollController;

  /// Whether to set sc12 initison offset to the value from sc11
  final bool sc12toSc11Position;

  /// Positions of 2 pairs of scroll controllers (sc11|sc12 and sc21|sc22)
  /// will be synchronized, attached scrollables will copy the positions
  final Widget Function(
      BuildContext context,
      ScrollController sc11,
      ScrollController sc12,
      ScrollController sc21,
      ScrollController sc22) builder;

  @override
  SyncedScrollControllersState createState() => SyncedScrollControllersState();
}

class SyncedScrollControllersState extends State<SyncedScrollControllers> {
  ScrollController? _sc11;
  late ScrollController _sc12;
  late ScrollController _sc21;
  late ScrollController _sc22;

  final List<void Function()> _listeners = [];

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void didUpdateWidget(SyncedScrollControllers oldWidget) {
    super.didUpdateWidget(oldWidget);
    _disposeOrUnsubscribe();
    _initControllers();
  }

  @override
  void dispose() {
    _disposeOrUnsubscribe();
    super.dispose();
  }

  void _initControllers() {
    _doNotReissueJump.clear();
    var offset =
        _sc11 == null || _sc11!.positions.isEmpty ? 0.0 : _sc11!.offset;
    if (widget.scrollController != null) {
      _sc11 = widget.scrollController!;
      if (_sc11!.positions.isNotEmpty) {
        offset = _sc11!.offset;
      }
    } else {
      _sc11 = ScrollController();
    }

    _sc12 = ScrollController(
        initialScrollOffset: widget.sc12toSc11Position ? offset : 0.0);

    _sc21 = ScrollController();
    _sc22 = ScrollController();

    _syncScrollControllers(_sc11!, _sc12);
    _syncScrollControllers(_sc21, _sc22);
  }

  void _disposeOrUnsubscribe() {
    if (widget.scrollController == _sc11) {
      _sc11?.removeListener(_listeners[0]);
    } else {
      _sc11?.dispose();
    }
    _sc12.dispose();
    _sc21.dispose();
    _sc22.dispose();
    _listeners.clear();
  }

  final Map<ScrollController, bool> _doNotReissueJump = {};

  void _syncScrollControllers(ScrollController sc1, ScrollController sc2) {
    var l = () => _jumpToNoCascade(sc1, sc2);
    sc1.addListener(l);
    _listeners.add(l);
    l = () => _jumpToNoCascade(sc2, sc1);
    sc2.addListener(l);
  }

  void _jumpToNoCascade(ScrollController master, ScrollController slave) {
    //print('$master $slave');
    if (!slave.hasClients || slave.position.outOfRange) {
      return; //outOfRange check for bounce case, bug #113
    }
    if (_doNotReissueJump[master] == null ||
        _doNotReissueJump[master]! == false) {
      _doNotReissueJump[slave] = true;
      slave.jumpTo(master.offset);
    } else {
      _doNotReissueJump[master] = false;
    }
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, _sc11!, _sc12, _sc21, _sc22);
}
