// ignore_for_file: avoid_void_async
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/models/models.dart';
import 'package:helppay_core/utils/utils.dart';

part 'products_event.dart';
part 'products_state.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'products_bloc');

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final DataManager dataManager;

  ProductsBloc({
    required this.dataManager,
  }) : super(ProductsLoading()) {
    on<ProductsEvent>(_onEvent);
  }

  void _onEvent(
    ProductsEvent event,
    Emitter<ProductsState> emit,
  ) {
    if (event is ProductsInit) return _onProductsInit(event, emit);
    if (event is ProductsMakeMain) return _onProductsMakeMain(event, emit);
    if (event is ProductsDelete) return _onProductsDelete(event, emit);
    if (event is ProductsAdd) return _onProductsAdd(event, emit);
    if (event is ProductRename) return _onProductRename(event, emit);
    if (event is GetProductBalance) return _onGetProductBalance(event, emit);
  }

  void _onProductsInit(
    ProductsInit event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    emit(ProductsInitial(
        accountParams: dataManager.accountParams,
        cardParams: dataManager.cardParams,
        accountsList: dataManager.accountsList,
        cardsList: dataManager.cardsList,
        mainProduct: dataManager.mainProduct,
        mainProductType: dataManager.mainProductType));
  }

  void _onProductsMakeMain(
    ProductsMakeMain event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    final prevMainProduct = dataManager.mainProduct;
    _log('prev main product');
    final prevMainProductTypePan =
        prevMainProduct?.params.findByAlias(AliasList.typePan);
    final prevMainProductDefaultFlag =
        prevMainProduct?.params.findByAlias(AliasList.defaultFlag);

    MdomEditUserRequestAccountsIsEditPan? prevMainProductForEdit;
    if (prevMainProduct != null) {
      prevMainProductForEdit = MdomEditUserRequestAccountsIsEditPan(
          value: prevMainProduct.params.findByAlias(AliasList.number)!.evalue!,
          params: MdomRequestParams(params: [
            MdomRequestParam(
                evalue: prevMainProductTypePan!.evalue,
                name: prevMainProductTypePan.name,
                id: prevMainProductTypePan.id,
                idParent: prevMainProductTypePan.idParent,
                alias: prevMainProductTypePan.alias),
            MdomRequestParam(
                evalue: '0',
                name: prevMainProductDefaultFlag!.name,
                id: prevMainProductDefaultFlag.id,
                idParent: prevMainProductDefaultFlag.idParent,
                alias: prevMainProductDefaultFlag.alias)
          ]));
    }

    final newMainProduct = event.product;
    _log('new product ${event.product}');
    _log(
        'new product ${event.product?.params.findByAlias(AliasList.cardId) ?? 'cardID not found'}');

    final newMainProductTypePan =
        newMainProduct?.params.findByAlias(AliasList.typePan);
    final newMainProductDefaultFlag =
        newMainProduct?.params.findByAlias(AliasList.defaultFlag);

    final newMainProductForEdit = MdomEditUserRequestAccountsIsEditPan(
        value: newMainProduct!.params.findByAlias(AliasList.number)!.evalue!,
        params: MdomRequestParams(params: [
          MdomRequestParam(
              evalue: newMainProductTypePan!.evalue,
              name: newMainProductTypePan.name,
              id: newMainProductTypePan.id,
              idParent: newMainProductTypePan.idParent,
              alias: newMainProductTypePan.alias),
          MdomRequestParam(
              evalue: '1',
              name: newMainProductDefaultFlag!.name,
              id: newMainProductDefaultFlag.id,
              idParent: newMainProductDefaultFlag.idParent,
              alias: newMainProductDefaultFlag.alias)
        ]));

    try {
      MdomEditUserResponse? response;
      //To avoid null error when main product do not exists in DB
      if (prevMainProductForEdit != null) {
        response = await dataManager.editUserRequest(
            products: MdomEditUserRequestProducts(
                isEdit: MdomEditUserRequestProductsIsEdit(
                    pan: [prevMainProductForEdit, newMainProductForEdit])));
      } else {
        response = await dataManager.editUserRequest(
            products: MdomEditUserRequestProducts(
                isEdit: MdomEditUserRequestProductsIsEdit(
                    pan: [newMainProductForEdit])));
      }
      if (response.errorCode.evalue == 0) {
        if (prevMainProduct != null) {
          dataManager.mainProduct?.params
              .findByAlias(AliasList.defaultFlag)
              ?.evalue = '0';
        }
        event.product?.params.findByAlias(AliasList.defaultFlag)?.evalue = '1';

        emit(ProductsSuccessMakeMain());
      } else {
        emit(ProductsErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText));
      }
    } catch (error) {
      emit(ProductsError(error: error));
    }
    emit(ProductsInitial(
        accountParams: dataManager.accountParams,
        cardParams: dataManager.cardParams,
        accountsList: dataManager.accountsList,
        cardsList: dataManager.cardsList,
        mainProduct: dataManager.mainProduct,
        mainProductType: dataManager.mainProductType));
  }

  void _onProductsDelete(
    ProductsDelete event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    try {
      final response = await dataManager.editUserRequest(
          products: MdomEditUserRequestProducts(
              isDel: MdomEditUserRequestProductsIsDel(pan: [
        event.product!.params.findByAlias(AliasList.number)!.evalue!
      ])));
      if (response.errorCode.evalue == 0) {
        dataManager.userProducts?.current?.remove(event.product);

        emit(ProductsSuccessDelete());
      } else {
        emit(ProductsErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText));
      }
    } catch (error) {
      emit(ProductsError(error: error));
    }

    emit(ProductsInitial(
        accountParams: dataManager.accountParams,
        cardParams: dataManager.cardParams,
        accountsList: dataManager.accountsList,
        cardsList: dataManager.cardsList,
        mainProduct: dataManager.mainProduct,
        mainProductType: dataManager.mainProductType));
  }

  void _onProductsAdd(
    ProductsAdd event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    final params = event.params
        .map((e) => MdomRequestParam(
            evalue: e.evalue,
            name: e.name,
            id: e.id,
            idParent: e.idParent,
            alias: e.alias))
        .toList();

    try {
      final response = await dataManager.editUserRequest(
          products: MdomEditUserRequestProducts(
              isAdd: MdomEditUserRequestProductsIsAdd(products: [
        MdomEditUserRequestAccountsIsAddProduct(
            params: MdomRequestParams(params: params))
      ])));
      if (response.errorCode.evalue == 0) {
        dataManager.userProducts?.current?.add(MdomLoginResponseProductsCurrent(
            params: MdomResponseParams(params: event.params)));

        emit(ProductsSuccessAdd(tab: event.tab));
      } else {
        emit(ProductsErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText));
      }
    } catch (error) {
      emit(ProductsError(error: error));
    }

    emit(ProductsInitial(
        accountParams: dataManager.accountParams,
        cardParams: dataManager.cardParams,
        accountsList: dataManager.accountsList,
        cardsList: dataManager.cardsList,
        mainProduct: dataManager.mainProduct,
        mainProductType: dataManager.mainProductType));
  }

  void _onProductRename(
    ProductRename event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    final product = dataManager.userProducts?.current?.singleWhere((p) {
      final pan = p.params.findByAlias(AliasList.number);
      return pan?.evalue == event.pan;
    });
    final productTypePan = product!.params.findByAlias(AliasList.typePan);

    final changedProductForEdit = MdomEditUserRequestAccountsIsEditPan(
        value: event.pan,
        params: MdomRequestParams(params: [
          MdomRequestParam(
              evalue: productTypePan!.evalue,
              name: productTypePan.name,
              id: productTypePan.id,
              idParent: productTypePan.idParent,
              alias: productTypePan.alias),
          MdomRequestParam(
              evalue: event.nameParam.evalue,
              name: event.nameParam.name,
              id: event.nameParam.id,
              idParent: event.nameParam.idParent,
              alias: event.nameParam.alias)
        ]));

    try {
      final response = await dataManager.editUserRequest(
          products: MdomEditUserRequestProducts(
              isEdit: MdomEditUserRequestProductsIsEdit(
                  pan: [changedProductForEdit])));
      if (response.errorCode.evalue == 0) {
        final productName = product.params.findByAlias(AliasList.productName);
        productName?.evalue = event.nameParam.evalue;

        emit(ProductsSuccessRename());
      } else {
        emit(ProductsErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText));
      }
    } catch (error) {
      emit(ProductsError(error: error));
    }
    emit(
      ProductsInitial(
        accountParams: dataManager.accountParams,
        cardParams: dataManager.cardParams,
        accountsList: dataManager.accountsList,
        cardsList: dataManager.cardsList,
        mainProduct: dataManager.mainProduct,
        mainProductType: dataManager.mainProductType,
      ),
    );
  }

  void _onGetProductBalance(
    GetProductBalance event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      emit(ProductsInitial(
        balanceRequested: true,
        accountParams: dataManager.accountParams,
        cardParams: dataManager.cardParams,
        accountsList: dataManager.accountsList,
        cardsList: dataManager.cardsList,
        mainProduct: dataManager.mainProduct,
        mainProductType: dataManager.mainProductType,
      ));
      final response = await dataManager.getBalanceRequest(
        pan: event.pan,
        typePan: event.typePan,
        diType: 9120,
      );
      //   pan: event.pan,
      //   typePan: event.typePan,
      //   diType: '', //TODO fix this idk what must be there
      // );
      if (response.errorCode == 0) {
        // emit(ProductsSuccessAdd(tab: event.tab));
        // _log(
        // '${event.typePan == 'ACCOUNT' ? 'Account' : 'Card'} balance is ${response.balance?.amount}');

        emit(ProductsBalanceLoaded(
          balance: response.balance,
        ));
        emit(ProductsInitial(
          balanceRequested: false,
          accountParams: dataManager.accountParams,
          cardParams: dataManager.cardParams,
          accountsList: dataManager.accountsList,
          cardsList: dataManager.cardsList,
          mainProduct: dataManager.mainProduct,
          mainProductType: dataManager.mainProductType,
        ));
      } else {
        emit(
          ProductsErrorKomplat(
            errorCode: response.errorCode,
            errorMessage: response.errorText,
          ),
        );
        emit(
          ProductsInitial(
            balanceRequested: false,
            accountParams: dataManager.accountParams,
            cardParams: dataManager.cardParams,
            accountsList: dataManager.accountsList,
            cardsList: dataManager.cardsList,
            mainProduct: dataManager.mainProduct,
            mainProductType: dataManager.mainProductType,
          ),
        );
      }
    } catch (error) {
      emit(ProductsError(error: error));
      emit(
        ProductsInitial(
          balanceRequested: false,
          accountParams: dataManager.accountParams,
          cardParams: dataManager.cardParams,
          accountsList: dataManager.accountsList,
          cardsList: dataManager.cardsList,
          mainProduct: dataManager.mainProduct,
          mainProductType: dataManager.mainProductType,
        ),
      );
    }
  }
}
