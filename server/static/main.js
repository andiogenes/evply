// Для отображения основного меню по клику на бургер

const burger = document.body.querySelectorAll('.burger')[0];
const menu = document.querySelectorAll('.menu')[0];
const form = document.querySelectorAll('.form-string')[0];

form.addEventListener('click', (e) => {
	let target = e.target;
	if(target.classList.contains('form__close-btn')) {
		form.classList.toggle('form_active');
		return;
	}
	if(target.classList.contains('form__input_btn')) {
		form.classList.toggle('form_active');
	}
})

burger.addEventListener('click', (e) => {
	let target = e.target;
	menu.classList.toggle('menu_active');
	while (!target.classList.contains('burger')) {
		target = target.parentNode;
	}
	target.classList.toggle('burger_active');
});

// Для отображения пунктов списка
menu.addEventListener('click', (e) => {
	let target = e.target;
	while (!target.classList.contains('list__item')) {
		target = target.parentNode;
	}
	target.classList.toggle('list__item_active');
	const list = target.querySelectorAll('.list')[0];
	if(target.parentNode.classList.contains('list_primitives') && (target.id == "string_btn" || target.id == "symbol_btn" || target.id == "number_btn")) {
		form.classList.toggle(`form_active`);
	}
	if(list)
		list.classList.toggle('list_active');
});

