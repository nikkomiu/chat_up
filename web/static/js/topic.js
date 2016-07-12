let Topic = {
  init(socket, element) {
    if (!element) { return }

    let topicId = element.getAttribute("data-topic-id")
    let chatInput = document.getElementById("chat-input")
    let chatButton = document.getElementById("chat-submit")

    if (!topicId) { return }

    let topicChannel = socket.channel(`topic:${topicId}`)

    topicChannel.join()
      .receive("ok", resp => {
        console.log(resp)
      })
  }
}

export default Topic
