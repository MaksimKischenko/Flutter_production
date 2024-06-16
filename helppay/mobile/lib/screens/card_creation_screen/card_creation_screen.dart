import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay/screens/card_creation_screen/screen_bodies/screens.dart';
import 'package:helppay/screens/screens.dart';
import 'package:helppay_core/helppay_core.dart';
class CardCreationScreen extends StatefulWidget {
  static const pageRoute = '/card_selection_screen';
  const CardCreationScreen({super.key});

  @override
  State<CardCreationScreen> createState() => _CardCreationScreenState();
}

class _CardCreationScreenState extends State<CardCreationScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  List<CardPayment>? cards;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<CardsIssueBloc, CardsIssueState>(
        listener: (context, state) {
          if(state is CardsIssueSuccessfulResponse) {
            cards = state.cards;
          } 
        },
        child: Scaffold(
          body: SafeArea(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: [
                PhoneNumberInputBody(
                  //0
                  navigationFunc: _navigateToPage,
                ),
                ConfirmationSMSBody(
                  //1
                  navigationFunc: _navigateToPage,
                ),
                IndificationNumberBody(
                  //2
                  navigationFunc: _navigateToPage,
                ),
                BnbCardAddScreen(
                  //3
                  navigationFunc: _navigateToPage,
                  cards: cards,            
                ),
                // CodeWordCreationBody(
                //   //4
                //   navigationFunc: _navigateToPage,
                // ),
                SuccessCardCreationBody(
                  //4
                  navigationFunc: _navigateToPage,
                ),

                // RegistrationUnavailabilityBody(
                //   //4
                //   navigationFunc: _navigateToPage,
                // ),
              ],
            ),
          ),
        ),
      );

  void _navigateToPage(int index) {
    setState(() {
      currentIndex = index;
    });
    SystemChannels.textInput.invokeMethod<void>('TextInput.hide');
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }
}
