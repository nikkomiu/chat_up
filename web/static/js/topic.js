let Topic = {
  init(socket) {
    console.log("something")

    this.onReady(2, socket)
  },

  onReady(topicId, socket) {
    console.log("onReady")

    let topicChannel = socket.channel(`topic:${topicId}`)

    topicChannel.join()
      .receive("ok", resp => {
        console.log(resp)
      })
  }
}

export default Topic
