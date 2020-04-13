class ProductControls {
  constructor(element) {
    this._addEventIntheForm();
    this.timeout = null;
    this.url = "";
  };

  submitUrl(url) {
    this.url = url;
    if(this.timeout) {
      clearTimeout(this.timeout);
    }
    this.timeout = setTimeout(() => this._fetchInfoOfURL(this.url), 3000);
  };

  _addEventIntheForm() {
    const urlInputField = document.querySelector('#url-input');
    urlInputField.addEventListener('change', (e) => this.submitUrl(e.target.value));
  }

  _fetchInfoOfURL(url) {
    this._enableLoader();
    fetch('/products', {
      method: "POST",
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ url: url})
    })
      .then((response) => response.json() )
      .then((data) => {
        this._setDataToElements(data.data);
        this._disableLoader();
      })
      .catch((error) => {
        this._disableLoader();
        console.log(error);
      });
  }

  _setDataToElements(data) {
    document.querySelector("#title").innerHTML = data.title;
    document.querySelector("#description").innerHTML = data.description;
    document.querySelector("#price").innerHTML = data.price;
    document.querySelector("#mobile_number").innerHTML = data.mobile_number;
    document.querySelector("#last_updated").innerHTML = data.updated_at;
  }

  _enableLoader() {
    document.getElementById("loader").innerHTML = "Loading....";
  }

  _disableLoader() {
    document.getElementById("loader").innerHTML = "";
  }
};

window.addEventListener('load', () => {
  const urlInputField = document.querySelector('#url-input');
  new ProductControls(urlInputField);
});
