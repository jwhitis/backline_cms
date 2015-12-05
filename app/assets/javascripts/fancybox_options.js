var fancyboxOptions = {
  padding: 0,
  margin: 15,
  tpl: {
    closeBtn: '<a title="Close" class="fancybox-item close-btn" href="javascript:;">CLOSE</a>',
    next: '<a title="Next" class="fancybox-nav fancybox-next" href="javascript:;"><i class="fa fa-chevron-right"></i></a>',
    prev: '<a title="Previous" class="fancybox-nav fancybox-prev" href="javascript:;"><i class="fa fa-chevron-left"></i></a>'
  },
  helpers: {
    title: {
      type: "over"
    },
    overlay: {
      css: {
        background: "rgba(0, 0, 0, .9)"
      }
    }
  }
}