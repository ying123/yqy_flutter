class MyPDFViewerTooltip {
  final String first;
  final String previous;
  final String next;
  final String last;
  final String pick;
  final String jump;

  const MyPDFViewerTooltip(
      {this.first = "首页",
        this.previous = "上一页",
        this.next = "下一页",
        this.last = "尾页",
        this.pick = "选择页码",
        this.jump = "切换"});
}
