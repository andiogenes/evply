// Для отображения основного меню по клику на бургер

const burger = document.body.querySelectorAll('.burger')[0];
const menu = document.querySelectorAll('.menu')[0];
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
	list.classList.toggle('list_active');
});

