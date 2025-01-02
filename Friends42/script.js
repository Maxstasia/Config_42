document.querySelectorAll('button, .card.shadow.m-2.pl-fix.card-size.grow, .sm-t.case, .btn, input[type="submit"]').forEach(button => {
	const initialBackground = button.style.background;
	button.addEventListener('mousemove', e => {
		const rect = button.getBoundingClientRect();
		const x = e.clientX - rect.left;
		const y = e.clientY - rect.top;
		button.style.background = `radial-gradient(circle at ${x}px ${y}px, #ff00cc, #3333ff)`});
	button.addEventListener('mouseleave', () => {
		button.style.background = initialBackground});
});