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
    var art=<Article artId={e.target.dataset.id}/>;
    ReactDOM.render(
        art,
        document.getElementById("page")
    );
}

class Article extends React.Component{
    constructor(props){
        super(props);
        this.state={art:[]};
    }

    componentWillMount() {
        console.log('Component WILL MOUNT!')
    }
    componentDidMount() {
        var artId=this.props.artId;
        $.post("fetchArticle", {
            id:artId,
            name:sname
        }, function (data, status) {
            console.log(data);
            var json=JSON.parse(data);
            var art=(<div className={"col-sm-12"}>
                <h1 className={"col-sm-6"}>{json[0]['title']}</h1>
                <span className={"col-sm-6"}>{json[0]['theme']}</span>
                <div class="section" dangerouslySetInnerHTML={{__html: json[0]['content']}}/>
            </div>);
            this.state.art.push(art);
            this.setState(this.state);
        }.bind(this));

        console.log('Component DID MOUNT!')
    }
    componentWillReceiveProps(newProps) {
        console.log('Component WILL RECEIVE PROPS!')
    }
    shouldComponentUpdate(newProps, newState) {
        return true;
    }
    componentWillUpdate(nextProps, nextState) {
        console.log('Component WILL UPDATE!');
    }
    componentDidUpdate(prevProps, prevState) {
        console.log('Component DID UPDATE!')
    }
    componentWillUnmount() {
        console.log('Component WILL UNMOUNT!')
    }

    render() {
        return <div>{this.state.art}</div>;
    }

}

class VerifyDialog extends React.Component{
    render(){
        return <div><label htmlFor="modal-control">Answer my question then I can let you in</label>
            <input type="checkbox" id="modal-control" className={"modal"}/>
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

class ArticlePage extends React.Component{
    constructor(props){
        super(props);
        this.state={articleArray:[]};
    }

    componentWillMount() {
        console.log('Component WILL MOUNT!')
    }
    componentDidMount() {
        var ip;
        var conf=$.ajax({url:"info",async:false}).then(function (data, status) {
            ip=data.split("\n")[0];
            console.log(ip);
        });

        $.post("articles", {name: sname}, function (data, status) {
            var json=JSON.parse(data);
            console.log(json);
            for(var i=0; i<json.length; i++) {
                var a=(<div class="card col-sm-12">
                    <h3 class="section click" data-id={json[i]['id']} onClick={articleClick}>
                        {json[i]['title']}
                    </h3>
                    <img src={"http://"+ip+":12333/dataServerCtrl/"+json[i]['cover_img']}/>
                    <div class="section" dangerouslySetInnerHTML={{__html: json[i]['description']}}/>
                </div>);
                this.state.articleArray.push(a);
            }
            this.setState(this.state);
        }.bind(this));
        this.timerID=setInterval(()=>this.tick(), 1000);
        console.log('Component DID MOUNT!');


    }

    tick(){

    }
    componentWillReceiveProps(newProps) {
        console.log('Component WILL RECEIVE PROPS!')
    }
    shouldComponentUpdate(newProps, newState) {
        return true;
    }
    componentWillUpdate(nextProps, nextState) {
        console.log('Component WILL UPDATE!');
    }
    componentDidUpdate(prevProps, prevState) {
        console.log('Component DID UPDATE!')
    }
    componentWillUnmount() {
        clearInterval(this.timerID);
        console.log('Component WILL UNMOUNT!')
    }

    render() {
        return (<div class="row">{this.state.articleArray}</div>);
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