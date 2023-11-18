import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:adriel_flutter_app/portfolio/stack_card/stack_card.dart';
import 'package:adriel_flutter_app/portfolio/stack_card/indicator_model.dart';
import 'package:adriel_flutter_app/portfolio/stack_card/stack_dimension.dart';
import 'package:adriel_flutter_app/portfolio/stack_card/stack_type.dart';

class StackCard extends StatefulWidget {
  StackCard.builder(
      {this.stackType = StackType.middle,
      required this.itemBuilder,
      required this.itemCount,
      required this.dimension,
      this.stackOffset = const Offset(15, 15),
      required this.onSwap,
      this.displayIndicator = false,
      required this.displayIndicatorBuilder});

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final ValueChanged<int> onSwap;
  final bool displayIndicator;
  final IndicatorBuilder displayIndicatorBuilder;
  final StackDimension dimension;
  final StackType stackType;
  final Offset stackOffset;

  @override
  _StackCardState createState() => _StackCardState();
}

class _StackCardState extends State<StackCard> {
  var _pageController = PageController();
  var _currentPage = 0.0;
  var _width, _height;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page;
      });
    });

    if (widget.dimension == null) {
      _height = MediaQuery.of(context).size.height;
      _width = MediaQuery.of(context).size.width;
    } else {
      assert(widget.dimension.width > 0);
      assert(widget.dimension.height > 0);
      _width = widget.dimension.width;
      _height = widget.dimension.height;
    }

    return Stack(fit: StackFit.expand, children: <Widget>[
      _cardStack(),
      widget.displayIndicator ? _cardIndicator() : Container(),
      PageView.builder(
        onPageChanged: widget.onSwap,
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: widget.itemCount,
        itemBuilder: (context, index) {
          return Container();
        },
      )
    ]);
  }

  Widget _cardStack() {
    List<Widget> _cards = [];

    for (int i = widget.itemCount - 1; i >= 0; i--) {
      var sizeOffsetx =
          (widget.stackOffset.dx * i) - (_currentPage * widget.stackOffset.dx);
      var sizeOffsety =
          (widget.stackOffset.dy * i) - (_currentPage * widget.stackOffset.dy);

      var leftOffset =
          (widget.stackOffset.dx * i) - (_currentPage * widget.stackOffset.dx);
      var topOffset =
          (widget.stackOffset.dy * i) - (_currentPage * widget.stackOffset.dy);

      _cards.add(Positioned.fill(
        child: _cardbuilder(
            i,
            widget.stackType == StackType.middle
                ? _width - sizeOffsetx
                : _width,
            _height - sizeOffsety),
        top: topOffset,
        left: widget.stackType == StackType.middle
            ? (_currentPage > (i) ? -(_currentPage - i) * (_width * 4) : 0)
            : (_currentPage > (i)
                ? -(_currentPage - i) * (_width * 4)
                : leftOffset),
      ));
    }

    return Stack(fit: StackFit.expand, children: _cards);
  }

  Widget _cardbuilder(int index, double width, double height) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
            width: width * .8,
            height: height * .8,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 1, blurRadius: 2)
            ], borderRadius: BorderRadius.all(Radius.circular(12))),
            child: widget.itemBuilder(context, index)));
  }

  Widget _cardIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: SliderIndicator(
              length: widget.itemCount,
              activeIndex: _currentPage.round(),
              displayIndicatorIcon:
                  widget.displayIndicatorBuilder.displayIndicatorIcon,
              displayIndicatorActiveIcon:
                  widget.displayIndicatorBuilder.displayIndicatorActiveIcon,
              displayIndicatorColor:
                  widget.displayIndicatorBuilder.displayIndicatorColor,
              displayIndicatorActiveColor:
                  widget.displayIndicatorBuilder.displayIndicatorActiveColor,
              displayIndicatorSize:
                  widget.displayIndicatorBuilder.displayIndicatorSize)),
    );
  }
}