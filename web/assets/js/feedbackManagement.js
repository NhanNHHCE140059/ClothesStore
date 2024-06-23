
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
function searchByPhone(param) {
    var phoneSearch = param.value.trim();
    if (phoneSearch === "") {

        document.getElementById('pagination').style.display = 'flex';
        return;
    }

    document.getElementById('pagination').style.display = 'none';
    $.ajax({
        url: "/clothesstore/SearchFeedback",
        type: "get", //send it through get method
        data: {
            phoneSearch: phoneSearch
        },
        success: function (data) {
            var row = document.getElementById("contentFeedBack");
            row.innerHTML = data;
        },
        error: function (xhr) {

        }
    });
}
  function setActive(element, pageIndex) {
            var links = document.querySelectorAll('.page-link');
            links.forEach(function(link) {
                link.classList.remove('active');
            });
            element.classList.add('active');
            localStorage.setItem('activePage', pageIndex); // Save active page index to localStorage
        }

        // Set the initial active page link from localStorage
        document.addEventListener('DOMContentLoaded', function() {
            var activePage = localStorage.getItem('activePage');
            if (activePage) {
                var links = document.querySelectorAll('.page-link');
                links.forEach(function(link) {
                    if (link.textContent === activePage) {
                        link.classList.add('active');
                    }
                });
            } else {
                var links = document.querySelectorAll('.page-link');
                if (links.length > 0) {
                    links[0].classList.add('active'); // Set the first page link as active initially
                }
            }
        });
