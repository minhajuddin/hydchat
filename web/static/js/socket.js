import {
  Socket
}
from "phoenix"

let socket = new Socket("/socket", {
  params: {
    token: window.userToken
  }
})

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("rooms:lobby", {})
channel.join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp)
  })
  .receive("error", resp => {
    console.log("Unable to join", resp)
  })

channel.push("get_welcome", {})

let messages = $("#messages")
let input = $("#input")

input.on("keypress", e => {
  if (e.keyCode != 13) {
    return
  }

  e.preventDefault()

  channel.push("new_msg", {
    user: getHandle(),
    text: input.val()
  })
  input.val('')
})

function getHandle() {
  let handle = localStorage.getItem('handle')
  if (!handle) {
    handle = prompt("What do you want us to call you?");
    localStorage.setItem('handle', handle)
  }
  return handle
}

channel.on("info", msg => {
  console.log(msg)
  messages.append(`@system: ${msg.body}`)
})

channel.on("recv_msg", msg => {
  console.log(msg)
  messages.append(`<p class=message>@${msg.user}: ${msg.text}</p>`)
})

export
default socket
