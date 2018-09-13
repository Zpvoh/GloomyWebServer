function commentSubmit(e) {
    var id=e.target.dataset.artid;

    $.post("addArtComment", {
        name:sname,
        id: id,
        username: $("#Username").val(),
        comment: $("#Comment").val()
    }, function (data, status) {
        console.log(data);
        $("#Username").val("");
        $("#Comment").val("");
        this.requestFor();
    }.bind(this));
}

function commentClear() {
    $("#Username").val("");
    $("#Comment").val("");
}

class Comment extends React.Component{
    constructor(props){
        super(props);
        this.state={art:[]};
    }

    componentWillMount() {
        console.log('Component WILL MOUNT!')
    }
    componentDidMount() {
        var comment=<div class="card commentCard">
            <div class="section">{this.props.name}</div>
            <div class="section dark">{this.props.comment}</div>
        </div>;

            this.state.art.push(comment);
            this.setState(this.state);

        console.log('Component DID MOUNT!')
    }
    shouldComponentUpdate(newProps, newState) {
        return true;
    }

    render() {
        return <div>{this.state.art}</div>;
    }

}

class CommentList extends React.Component{
    constructor(props){
        super(props);
        this.state={art:[]};
    }

    requestFor(){
        var artId=this.props.artId;

        $.post("artComment", {
            id:artId,
            name:sname
        }, function (data, status) {
            console.log(data);
            var json=JSON.parse(data);
            var comments=[];
            for(var i=0; i<json.length; i++){
                var comment=<Comment name={json[i]['name']} comment={json[i]['comment']}/>
                comments.push(comment);
            }
            var newComment=<div class="card newComment">
                <div class="input-group">
                    <label for="username">Username</label>
                    <input type="text" id="Username" placeholder="Username"/>
                    <label for="comment">Comment</label>
                    <textarea id="Comment" placeholder="Comment"/>
                </div>
                <div class="button-group">
                    <button className={"primary"} onClick={commentSubmit.bind(this)} data-artId={artId}>提交</button>
                    <button onClick={commentClear}>清除</button>
                </div>
            </div>;

            comments.push(newComment);

            var art=(<span className={"col-sm-2", "comment"}>
                <label htmlFor="drawer-control" class="drawer-toggle persistent"><span><em>Comments</em></span></label>

                <input type="checkbox" id="drawer-control" class="drawer persistent"/>
                <div>
                    <label htmlFor="drawer-control" class="drawer-close"/>
                    {comments}
                </div>
            </span>);
            this.state.art.pop();
            this.state.art.push(art);
            this.setState(this.state);
        }.bind(this));
    }

    componentWillMount() {
        console.log('Component WILL MOUNT!')
    }
    componentDidMount() {
        var spinner=<div class="spinner primary"/>;
        this.state.art.push(spinner);
        this.setState(this.state);
        this.requestFor();
        console.log('Component DID MOUNT!')
    }
    shouldComponentUpdate(newProps, newState) {
        return true;
    }

    render() {
        return <div>{this.state.art}</div>;
    }

}