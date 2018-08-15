class Article extends React.Component{
    componentWillMount() {
        console.log('Component WILL MOUNT!')
    }
    componentDidMount() {
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
        return <div class="card">
                <h3 class="section">{this.props.title}</h3>
                <div class="section">{this.props.content}</div>
               </div>
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
        $.post("articles", {name: "name"}, function (data, status) {
            var json=JSON.parse(data);
            console.log(json);
            for(var i=0; i<json.length; i++) {
                var a=(<div class="card col-sm-3">
                    <h3 class="section">{json[i]['name']}</h3>
                    <div class="section" dangerouslySetInnerHTML={{__html: json[i]['content']}}></div>
                </div>);
                this.state.articleArray.push(a);
            }
            this.setState(this.state);
        }.bind(this));
        this.timerID=setInterval(()=>this.tick(), 1000);
        console.log('Component DID MOUNT!')
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

var logo=<span class="logo">GLOOMY</span>;
var article=<span class="button" id="articleEntrance">articles</span>
var music=<span class="button">musics</span>
var movie=<span class="button">movies</span>

var headArr=[logo, article, music, movie];
var head=<header>{headArr}</header>;
var page=<ArticlePage/>;
var foot=<footer>2018-2020</footer>

var elementArr=[head];
elementArr.push(page);
elementArr.push(foot);

ReactDOM.render(
    elementArr,
    document.getElementsByTagName("body")[0]
);