var sname="";

var logo=<span class="logo button" id="homePage">Gloomy</span>;
var article=<span class="button" id="articleEntrance">articles</span>;
var music=<span class="button">musics</span>;
var movie=<span class="button">movies</span>;
var corpus=<span className={"button"}>corpus</span>;
var chatRoom=<span className={"button"}>chatRoom</span>

var headArr=[logo, article, music, movie, corpus, chatRoom];
var head=<header class="sticky">{headArr}</header>;
var pageDiv=<div></div>;
var foot=<footer class="sticky">2018-2020 Emacipatevoh's Warehouse</footer>;

var elementArr=[head, pageDiv, foot];

function articleClick(e){
    var art=<Article artId={e.target.parentElement.dataset.id}/>;
    ReactDOM.render(
        art,
        document.getElementById("page")
    );
}

class VerifyDialog extends React.Component{
    render(){
        return <div>
            <input type="checkbox" id="modal-control" className={"modal"} checked="checked"/>
            <div>
                <div className="card">
                    <label htmlFor="modal-control" className={"modal-close"}/>
                    <h2 className="section">Verify</h2>
                    <p className="section">

                        <div>
                            What is owner of the website's common screen name?
                            <input type="password" name="password" id="nameTxt"/>
                        </div>
                        <input type="button" value="Login" id="loginBt"/>

                    </p>
                </div>
            </div></div>;
    }
}

function homeRender() {
    var page=<h1>Welcome to the Gloomy</h1>;
    ReactDOM.render(
        page,
        document.getElementById("page")
    );
}

function articleRender() {
    var page=<ArticlePage/>;
    ReactDOM.render(
        page,
        document.getElementById("page")
    );
}

function login() {
    sname=getCookie("name");

    if(sname==="" || sname==="undefined"){
        sname=$("#nameTxt").val();
    }

    $.post("articles", {
        name:sname
    },function (data, status) {
        console.log(data);

        if(data==='invalid\n') {
            alert("You don't know that");
        }else{
            $("#dialog").hide();
            setCookie("name", sname, 1);

            ReactDOM.render(
                headArr,
                document.getElementById("head")
            );

            homeRender();

            ReactDOM.render(
                foot,
                document.getElementById("foot")
            );

            $("#homePage").click(homeRender);
            $("#articleEntrance").click(articleRender);
        }

    });
}

var dialog=<VerifyDialog/>;

ReactDOM.render(
    dialog,
    document.getElementById("dialog")
);

login();

$("#loginBt").click(login);