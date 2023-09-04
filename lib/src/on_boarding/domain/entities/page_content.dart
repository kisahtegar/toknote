import 'package:equatable/equatable.dart';

import 'package:toknote/core/res/media_res.dart';

/// Represents the content of a page in an onboarding screen.
class PageContent extends Equatable {
  /// Creates a new instance of [PageContent] with the provided parameters.
  const PageContent({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonName,
  });

  /// Creates a [PageContent] instance for the first onboarding page.
  const PageContent.first()
      : this(
          image: MediaRes.shopHouse,
          title: 'Manage Your Store',
          description: 'Easily organize your selling items for the better',
          buttonName: 'Next',
        );

  /// Creates a [PageContent] instance for the second onboarding page.
  const PageContent.second()
      : this(
          image: MediaRes.shopList,
          title: 'Record Your Activities',
          description:
              'You can record your activities starting from incoming or '
              'outgoing goods and so on',
          buttonName: 'Next',
        );

  /// Creates a [PageContent] instance for the third onboarding page.
  const PageContent.third()
      : this(
          image: MediaRes.shopView,
          title: 'Easy to Join the lesson',
          description: 'Find the convenience of managing your ' "store's goods",
          buttonName: 'Get Started',
        );

  /// The image associated with this page's content.
  final String image;

  /// The title of this page's content.
  final String title;

  /// The description of this page's content.
  final String description;

  /// The label for the button related to this page's content.
  final String buttonName;

  @override
  List<Object?> get props => [image, title, description, buttonName];
}
