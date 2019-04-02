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
        var spinner=<div class="spinner primary"/>;
        this.state.art.push(spinner);
        this.setState(this.state);

        $.post("fetchArticle", {
            id:artId,
            name:sname
        }, function (data, status) {
            console.log(data);
            var json=JSON.parse(data);
            var art=(<div className={"col-sm-12"}>
                <CommentList artId={artId}/>
                <h1 className={"col-sm-6"}>{json[0]['title']}</h1>
                <span className={"col-sm-6"}>{json[0]['theme']}</span>
                <div class="section" dangerouslySetInnerHTML={{__html: json[0]['content']}}/>
            </div>);
            this.state.art.pop();
            this.state.art.push(art);
            this.setState(this.state);
        }.bind(this));

        console.log('Component DID MOUNT!')
    }
    shouldComponentUpdate(newProps, newState) {
        return true;
    }

    render() {
        return <div>{this.state.art}</div>;
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
                var a=(<div class="card col-sm-12" data-id={json[i]['id']} onClick={articleClick}>
                    <h3 class="section click">
                        {json[i]['title']}
                    </h3>
                    <img src={"http://"+ip+":12333/dataServerCtrl/"+json[i]['cover_img']}/>
                    <div class="section" dangerouslySetInnerHTML={{__html: json[i]['description']}}/>
                </div>);
                this.state.articleArray.push(a);
            }
            this.setState(this.state);
        }.bind(this));

        console.log('Component DID MOUNT!');


    }

    shouldComponentUpdate(newProps, newState) {
        return true;
    }

    render() {
        return (<div class="row">{this.state.articleArray}</div>);
    }
}
