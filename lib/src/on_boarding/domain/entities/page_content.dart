import 'package:equatable/equatable.dart';

import 'package:toknote/core/res/media_res.dart';

class PageContent extends Equatable {
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContent.first()
      : this(
          image: MediaRes.shopHouse,
          title: 'Manage Your Store',
          description: 'easily organize your selling items for the better ',
        );

  const PageContent.second()
      : this(
          image: MediaRes.shopList,
          title: 'Record Your Activities',
          description:
              'You can record your activities starting from incoming or outgoing goods and so on',
        );

  const PageContent.third()
      : this(
          image: MediaRes.shopView,
          title: 'Easy to join the lesson',
          description: 'Find the convenience of managing your ' "store's goods",
        );

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
