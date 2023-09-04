import 'package:equatable/equatable.dart';

import 'package:toknote/core/res/media_res.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonName,
  });

  const PageContent.first()
      : this(
          image: MediaRes.shopHouse,
          title: 'Manage Your Store',
          description: 'easily organize your selling items for the better ',
          buttonName: 'Next',
        );

  const PageContent.second()
      : this(
          image: MediaRes.shopList,
          title: 'Record Your Activities',
          description:
              'You can record your activities starting from incoming or '
              'outgoing goods and so on',
          buttonName: 'Next',
        );

  const PageContent.third()
      : this(
          image: MediaRes.shopView,
          title: 'Easy to join the lesson',
          description: 'Find the convenience of managing your ' "store's goods",
          buttonName: 'Get Started',
        );

  final String image;
  final String title;
  final String description;
  final String buttonName;

  @override
  List<Object?> get props => [image, title, description, buttonName];
}
