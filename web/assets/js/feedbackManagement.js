
document.querySelectorAll('.menu-item').forEach(item => {
    item.addEventListener('click', () => {
        const submenu = item.nextElementSibling.nextElementSibling;
        const separator = item.nextElementSibling;
        if (submenu.style.display === 'block') {
            submenu.style.display = 'none';
            separator.style.display = 'block';
            item.classList.remove('active');
        } else {
            document.querySelectorAll('.submenu').forEach(sub => sub.style.display = 'none');
            document.querySelectorAll('.separator').forEach(sep => sep.style.display = 'block');
            document.querySelectorAll('.menu-item').forEach(i => i.classList.remove('active'));
            submenu.style.display = 'block';
            separator.style.display = 'none';
            item.classList.add('active');
        }
    });
});
