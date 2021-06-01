class ConfirmDialogInfo {
  final String title, content, confirmButton, cancelButton;
  final Function successCallback;

  ConfirmDialogInfo(
      {this.title,
      this.content,
      this.confirmButton,
      this.cancelButton,
      this.successCallback});
}