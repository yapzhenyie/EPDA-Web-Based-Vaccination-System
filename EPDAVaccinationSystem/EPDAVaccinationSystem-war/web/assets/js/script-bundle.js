// Toggle active side bar
$(function () {
    var urlPath = window.location.pathname;
    if (urlPath !== undefined && urlPath !== '') {
        $(".components li a").each(function (i, element) {
            var hrefPath = $(element).attr('href');
            if (hrefPath !== undefined) {
                //console.log(hrefPath + " - " + urlPath);
                if (hrefPath.toLowerCase().endsWith(urlPath.toLowerCase())) {
                    $(element).closest("li").toggleClass("active");
                    return false;
                }
            }
        });
        $(".components li ul li a").each(function (i, element) {
            var hrefPath = $(element).attr('href');
            if (hrefPath !== undefined) {
                //console.log(hrefPath + " - " + urlPath);
                if (hrefPath.toLowerCase().endsWith(urlPath.toLowerCase())) {
                    $(element).toggleClass("active");
                    var parent = $(element).closest("ul").closest("li");
                    parent.toggleClass("active");
                    var tag = parent.find('a').attr('href');
                    $(tag).collapse('show');
                    return false;
                }
            }
        });
    }
});