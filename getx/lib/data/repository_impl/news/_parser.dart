part of 'news_repository_impl.dart';

class _Parser {
  HomeEntity parseHome(String html) {
    NewsEntity? trending;
    List<NewstCategoryEntity> categories = [];
    List<NewsEntity> news = [];
    try {
      dom.Document doc = parser.parse(html);
      try {
        dom.Element element = doc.getElementsByClassName('headline--main')[0];
        trending = NewsEntity(
          title: element
                  .getElementsByClassName('ui--a headline--main__title-link')[0]
                  .attributes['data-title'] ??
              '',
          image: element.getElementsByTagName('img')[0].attributes['src'],
          date: element.getElementsByClassName('timeago')[0].text,
          desc: element
              .getElementsByClassName('headline--main__short-desc')[0]
              .text,
          target: element.getElementsByTagName('a')[0].attributes['href'] ?? '',
        );
      } catch (_) {}
      try {
        categories = List.from(
          doc
              .getElementsByClassName('navbar--menu')[0]
              .getElementsByClassName('navbar--menu--item')
              .map(
                (e) => NewstCategoryEntity(
                  title: e.getElementsByTagName('a')[0].text.trim(),
                  target:
                      e.getElementsByTagName('a')[0].attributes['href'] ?? '',
                ),
              ),
        )
          ..removeWhere((element) => element.title.isEmpty)
          ..removeWhere((element) => element.title == 'Home');
      } catch (_) {}
      try {
        news = parseNewList(html);
      } catch (_) {}
      return HomeEntity(
        trending: trending,
        categories: categories,
        headLineNwes: news,
      );
    } catch (e, s) {
      throw ParserException(error: e, stackTrace: s);
    }
  }

  List<NewsEntity> parseByTag(String html) {
    try {
      return List<NewsEntity>.from(
        parser
            .parse(html)
            .getElementsByClassName('articles--iridescent-list')[0]
            .getElementsByTagName('article')
            .map(
              (e) => NewsEntity(
                title: e
                    .getElementsByClassName(
                        'articles--iridescent-list--text-item__title-link-text')[0]
                    .text
                    .trim(),
                target: e.getElementsByTagName('a')[0].attributes['href'] ?? '',
                image: e.getElementsByTagName('img')[0].attributes['src'],
                desc: e
                    .getElementsByClassName(
                        'articles--iridescent-list--text-item__summary articles--iridescent-list--text-item__summary-seo')[0]
                    .text
                    .trim(),
                date: e
                    .getElementsByClassName(
                        'articles--iridescent-list--text-item__time timeago')[0]
                    .text
                    .trim(),
              ),
            ),
      );
    } catch (e, s) {
      throw ParserException(error: e, stackTrace: s);
    }
  }

  List<NewsEntity> parseNewList(String html) {
    try {
      return List.from(
        parser
            .parse(html)
            .getElementsByClassName(
                'articles--iridescent-list--item articles--iridescent-list--text-item')
            .map(
              (e) => NewsEntity(
                title: e
                    .getElementsByClassName(
                        'articles--iridescent-list--text-item__title-link-text')[0]
                    .text
                    .trim(),
                image: e.getElementsByTagName('img')[0].attributes['data-src'],
                date: e.getElementsByTagName('time').isNotEmpty
                    ? e.getElementsByTagName('time')[0].text.trim()
                    : '',
                desc: e
                    .getElementsByClassName(
                        'articles--iridescent-list--text-item__summary articles--iridescent-list--text-item__summary-seo')[0]
                    .text
                    .trim(),
                target: e.getElementsByTagName('a')[0].attributes['href'] ?? '',
              ),
            ),
      );
    } catch (e, s) {
      throw ParserException(error: e, stackTrace: s);
    }
  }

  NewsReadEntiry parseRead(String html) {
    try {
      dom.Element element =
          parser.parse(html).getElementsByClassName('read-page-upper')[0];
      return NewsReadEntiry(
        title: element
            .getElementsByClassName('read-page--header--title entry-title')[0]
            .text
            .trim(),
        image: element
                .getElementsByClassName(
                    'read-page--photo-gallery--item__picture')[0]
                .getElementsByTagName('img')[0]
                .attributes['data-src'] ??
            "",
        desc: element
            .getElementsByClassName(
                'read-page--photo-gallery--item__caption')[0]
            .text
            .trim(),
        date: element
                .getElementsByClassName(
                    'read-page--header--author__datetime')[0]
                .attributes['datetime'] ??
            '',
        article: element
            .getElementsByClassName('article-content-body__item-page ')[0]
            .innerHtml,
      );
    } catch (e, s) {
      throw ParserException(error: e, stackTrace: s);
    }
  }
}
