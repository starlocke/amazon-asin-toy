class AsinApp extends React.Component {
    constructor(props) {
        super(props);
        this.handleProductsLoad = this.handleProductsLoad.bind(this);
        this.refresh = this.refresh.bind(this);
        this.state = {products: []};
    }

    handleProductsLoad(e){
        let products = JSON.parse(e.currentTarget.responseText);
        this.setState({ products: products });
    }

    componentDidMount(){
        this.refresh();
    }

    refresh(){
        let oReq = new XMLHttpRequest();
        oReq.addEventListener("load", this.handleProductsLoad);
        oReq.open("GET", "/products.json");
        oReq.send();
    }
    
    render() {
    return (
        <div>
            <h1>Amazon ASIN App</h1>
            <hr />

            <h2>Products Database</h2>
            <ProductsTable products={this.state.products} />
            <hr />

            <h2>Fetch Tool</h2>
            <FetchTool refresh={this.refresh} />
            <hr />
        </div>
    );
  }
}

class ProductsTable extends React.Component {
    render() {
        return (
            <table border="1">
                <thead>
                <tr>
                        <th colSpan="3"></th>
                        <th colSpan="3">Item</th>
                        <th colSpan="3">Package</th>
                    </tr>
                    <tr>
                        <th>ASIN</th>
                        <th>Product Group (Category)</th>
                        <th>Sales Rank</th>
                        <th>Width</th>
                        <th>Height</th>
                        <th>Length</th>
                        <th>Width</th>
                        <th>Height</th>
                        <th>Length</th>
                    </tr>
                </thead>
                <tbody>
                {
                    this.props.products.map(function(p, i){
                        return (<ProductRow key={i} product={p} />);
                    })
                }
                </tbody>
            </table>
        )
    }
}

class ProductRow extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            product: props.product
        }
    }

    render(){
        return (
            <tr>
                <td>
                    <a href={"https://www.amazon.com/dp/"+this.state.product.asin}>
                    {this.state.product.asin}
                    </a>
                </td>
                <td>{this.state.product.category}</td>
                <td>{this.state.product.rank}</td>
                <td>{this.state.product.item_width} {this.state.product.item_width_units}</td>
                <td>{this.state.product.item_height} {this.state.product.item_height_units}</td>
                <td>{this.state.product.item_length} {this.state.product.item_length_units}</td>
                <td>{this.state.product.package_width} {this.state.product.package_width_units}</td>
                <td>{this.state.product.package_height} {this.state.product.package_height_units}</td>
                <td>{this.state.product.package_length} {this.state.product.package_length_units}</td>
            </tr>
        )
    }
}

class FetchTool extends React.Component {
    constructor(props) {
        super(props);
        this.state = {asin_list: '', status: '...'};
        this.handleChange = this.handleChange.bind(this);
        this.doFetch = this.doFetch.bind(this);
    }

    doFetch(e) {
        e.preventDefault();
        // get non-empty lines, as array
        let asin_array = this.state.asin_list.split("\n").filter(word => word.length > 0);
        let refresh = this.props.refresh;
        let component = this;
        let now = new Date();
        component.setState( {status: 'Processing @ ' + now} );
        fetch('/products/fetch_batch.json', {
            method: 'POST', // or 'PUT'
            body: JSON.stringify({asins: asin_array}), 
            headers: new Headers({
              'Content-Type': 'application/json'
            })
          }).then(function(res){
              res.json()
            })
          .catch(function(error) {
              let now = new Date();
              component.setState( {status: 'Error @ ' + now} );
              console.error('Error:', error)
            })
          .then(function(response) {
              let now = new Date();
              component.setState( {status: 'Success @ ' + now} );
              refresh();
            });
    }

    handleChange(e) {
        this.setState({asin_list: e.target.value});
    }

    render() {
        return (
            <div>
                <form>
                    <label htmlFor="asin_list">List of ASINs, one per line.</label>
                    <textarea name="asin_list" id="asin_list" value={this.state.asin_list} onChange={this.handleChange}></textarea><br />
                    <p>* Since this is just a "toy" app, please limit the number of items to a small amount</p>
                    <p>Status: {this.state.status}</p>
                    <button onClick={this.doFetch}>Submit</button>
                </form>
            </div>
        )
    }
}


ReactDOM.render(
    <AsinApp name="Main" />,
    document.getElementById('asin_app')
);