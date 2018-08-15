$(document).ready(function () {
    $("#articleEntrance").click(function (){
        $.post("articles",
        {
            name:"name"
        },function (data, status) {
            $("body").append(data);
        });
    });
});