import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_all/flutter_html_all.dart';

final staticAnchorKey = GlobalKey();

Widget renderHTML(String html) {
  return Html(
    anchorKey: staticAnchorKey,
    data: html,
    style: {
      "table": Style(
        backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
      ),
      "th": Style(padding: HtmlPaddings.all(6), backgroundColor: Colors.grey),
      "td": Style(
        padding: HtmlPaddings.all(6),
        border: const Border(bottom: BorderSide(color: Colors.grey)),
      ),
      'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
      'flutter': Style(display: Display.block, fontSize: FontSize(5, Unit.em)),
      ".second-table": Style(backgroundColor: Colors.transparent),
      ".second-table tr td:first-child": Style(
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.end,
      ),
    },
    extensions: [
      TagWrapExtension(
        tagsToWrap: {"table"},
        builder: (child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: child,
          );
        },
      ),
      TagExtension(
        tagsToExtend: {"tex"},
        builder: (context) => Math.tex(
          context.innerHtml,
          mathStyle: MathStyle.display,
          textStyle: context.styledElement?.style.generateTextStyle(),
          onErrorFallback: (FlutterMathException e) {
            return Text(e.message);
          },
        ),
      ),
      TagExtension.inline(
        tagsToExtend: {"bird"},
        child: const TextSpan(text: "🐦"),
      ),
      TagExtension(
        tagsToExtend: {"flutter"},
        builder: (context) => CssBoxWidget(
          style: context.styledElement!.style,
          child: FlutterLogo(
            style: context.attributes['horizontal'] != null
                ? FlutterLogoStyle.horizontal
                : FlutterLogoStyle.markOnly,
            textColor: context.styledElement!.style.color!,
            size: context.styledElement!.style.fontSize!.value,
          ),
        ),
      ),
      ImageExtension(
        handleAssetImages: false,
        handleDataImages: false,
        networkDomains: {"flutter.dev"},
        child: const FlutterLogo(size: 36),
      ),
      ImageExtension(
        handleAssetImages: false,
        handleDataImages: false,
        networkDomains: {"mydomain.com"},
        networkHeaders: {"Custom-Header": "some-value"},
      ),
      const MathHtmlExtension(),
      const AudioHtmlExtension(),
      const VideoHtmlExtension(),
      const IframeHtmlExtension(),
      const TableHtmlExtension(),
      const SvgHtmlExtension(),
    ],
    onLinkTap: (url, _, __) {
      debugPrint("Opening $url...");
    },
    onCssParseError: (css, messages) {
      debugPrint("css that errored: $css");
      debugPrint("error messages:");
      for (var element in messages) {
        debugPrint(element.toString());
      }
      return '';
    },
  );
}
