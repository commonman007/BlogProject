console.log('hi')
console.log(document.querySelector('head').dataset)
App.comment = App.cable.subscriptions.create({
  channel: "CommentsChannel",
  blog_id: document.querySelector('head').dataset.blogId
}, {
  received: function (data) {
    $('#comment_message_' + data.blog_id).val('')
    $('#comments_' + data.blog_id).append(this.renderMessage(data));
    $("#comments_" + data.blog_id).scrollTop($("#comments_" + data.blog_id)[0].scrollHeight);
  },

  renderMessage: function (data) {
    return "<p class='text-break secondary'><span class='fw-light'>" + data.message + "</span>" +
      "<span class='fw-lighter fst-italic text-muted'>" + data.user + "</span>" +
      "<span class='fw-lighter fst-italic text-muted'>" + data.time + "</span>"
    "</p>"
  }
});