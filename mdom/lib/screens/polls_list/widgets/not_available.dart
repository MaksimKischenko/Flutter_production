import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class NotAvailable extends StatelessWidget {
  const NotAvailable({
    Key? key,
  }) : super(key: key);

  static const phones = <String>[
    '+375 29 633-64-55',
    '+375 17 279-34-19',
  ];

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffFFF8F0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/icon/polls_not_avaiable.svg'),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Опция «Голосования» платная',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffFF8A00),
                        letterSpacing: 0.1
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'В ваш пакет обслуживания она не входит. Для активации свяжитесь с ООО «Расвиком Сервис» по телефонам:',
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: phones.map(_phone).toList(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        // const SizedBox(height: 30),
        _feature(
          'Организуйте голосование онлайн прямо в приложении',
          imageName: 'poll_feature_1.png'
        ),
        _feature('Отправляйте клиенту оповещение о начале голосования'),
        _feature(
          'Просматривайте результаты голосования',
          imageName: 'poll_feature_2.png',
        ),
        _feature(
          'Контролируйте количество участников и их ответы',
          imageName: 'poll_feature_3.png',
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffFFF8F0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Для активации свяжитесь с ООО «Расвиком Сервис» по телефонам:',
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: phones.map(_phone).toList(),
              )
            ],
          ),
        ),
      ],
    ),
  );

  Widget _phone(String value) => GestureDetector(
    onTap: () => launchUrl(Uri.parse('tel:$value')),
    behavior: HitTestBehavior.translucent,
    child: Row(
      children: [
        const Icon(
          Icons.phone,
          color: Color(0xffA5998B),
          size: 12,
        ),
        const SizedBox(width: 4),
        Text(
          value,
        ),
      ],
    ),
  );

  Widget _feature(
    String text,
    {String? imageName,
  }) => Padding(
    padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
    child: Column(
      children: [
        SvgPicture.asset('assets/icon/polls_not_avaiable_feature.svg'),
        const SizedBox(height: 6),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        if (imageName != null)
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Image.asset('assets/images/$imageName'),
        ),
      ],
    ),
  );
}