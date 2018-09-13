class Comment extends React.Component{
    constructor(props){
        super(props);
        this.state={art:[]};
    }

    componentWillMount() {
        console.log('Component WILL MOUNT!')
    }
    componentDidMount() {
        var comment=<div class="card">
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

    componentWillMount() {
        console.log('Component WILL MOUNT!')
    }
    componentDidMount() {
        var artId=this.props.artId;
        var spinner=<div class="spinner primary"/>;
        this.state.art.push(spinner);
        this.setState(this.state);

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
            var art=(<span className={"col-sm-2"}>
                <label htmlFor="drawer-control" class="drawer-toggle persistent"><span className={"comment"}><em>Comments</em></span></label>

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

        console.log('Component DID MOUNT!')
    }
    shouldComponentUpdate(newProps, newState) {
        return true;
    }

    render() {
        return <div>{this.state.art}</div>;
    }

}