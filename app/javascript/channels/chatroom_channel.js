import consumer from "./consumer";

  const createMessage = ({user_id, name, message_id, date, content}) => {
    const currentUserId = document.getElementById('user_id').dataset.currentUserId;
    const classToApply = currentUserId === user_id ? "current_user_true" : "current_user_false"
    return (`<div class="message-container ${classToApply}" id="message-${message_id}">
      <i class="author">
        <span>${name}</span>
        <small>${date}</small>
      </i>
      <p>${content}</p>
    </div>`)
  }

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        const newMessage = createMessage(data.message)
        messagesContainer.insertAdjacentHTML('beforeend', newMessage); // called when data is broadcast in the cable
      },
    });
  }
}

export { initChatroomCable };
