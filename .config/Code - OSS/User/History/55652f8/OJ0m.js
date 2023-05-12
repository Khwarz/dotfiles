import './style.css'

// <div class="flex items-center justify-between my-8">
//     <span class="text-gray-700 font-semibold">Faire la lessive</span>
//     <button class="bg-red-100 px-3 py-2 rounded-md shadow-sm rounded-md text-red-700 flex-shrink-0">Supprimer</button>
// </div>

let form = document.querySelector("form")
const todoList = [];

form.addEventListener('submit', (e) => {
    e.preventDefault()
    let input = form.querySelector('input')

    if (input.value != "") {
        todoList.push(input.value)
    }

    form.reset()
    clearTodoListRender()
    renderTodoList()
});

function clearTodoListRender() {
    document.getElementById('todo-items').innerHTML = ''
}

function renderTodoList() {
    todoList.forEach((todoItem) => renderTodoListItem(todoItem))
}

function renderTodoListItem(todoItem) {
    const rootDiv = document.createElement('div')
    rootDiv.classList.add("flex", "items-center", "justify-between", "w-full")

    const span = document.createElement('span')
    span.innerHTML = todoItem
    span.classList.add("text-gray-700", "font-semibold")

    const deleteButton = document.createElement('button')
    deleteButton.innerHTML = "Supprimer"
    deleteButton.classList.add("bg-red-100", "px-3", "py-2", "rounded-md", "shadow-sm", "rounded-md", "text-red-700", "flex-shrink-0")

    rootDiv.appendChild(span)
    rootDiv.appendChild(deleteButton)

    document.getElementById('todo-items').appendChild(rootDiv)
}
