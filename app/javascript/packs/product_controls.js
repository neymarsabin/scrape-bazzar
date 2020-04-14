class ProductControls {
  constructor(element) {
    this._addEventIntheForm();
    this.timeout = null;
    this.url = "";
    this.regex = /https:\/\/hamrobazaar\.com\/i\d+(-\w+)+\.html/;
  };

  submitUrl() {
    document.getElementById("error").innerHTML = "";

    if(this.timeout) {
      clearTimeout(this.timeout);
    }
    this.timeout = setTimeout(() => this._fetchInfoOfURL(), 3000);
  };

  _addEventIntheForm() {
    const urlInputField = document.querySelector('#url-input');
    urlInputField.addEventListener('input', (e) => {
      this.url = e.target.value;
      if(true) {
        this.submitUrl();
      } else {
        document.getElementById("error").innerHTML = "Please Enter a valid URL!!!";
        return;
      }
    });
  };

  _fetchInfoOfURL() {
    this._enableLoader();
    fetch('/products', {
      method: "POST",
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ url: this.url})
    })
      .then((response) => {
        if (response.status === 200) {
          response.json().then((response) => {
            this._setDataToElements(response.data);
            this._disableLoader();
          });
        } else {
          response.json().then((response) => {
            this._disableLoader();
            document.getElementById("error").innerHTML = "Error: " + response.error;
            this._removeDataOfEelements();
          });
        }
      });
  }

  _setDataToElements(data) {
    document.querySelector("#title").innerHTML = "Title: " + data.title;
    document.querySelector("#description").innerHTML = "Description: " + data.description;
    document.querySelector("#price").innerHTML = "Price: Rs " + data.price;
    document.querySelector("#mobile_number").innerHTML = "Mobile Number: " + data.mobile_number;
    document.querySelector("#last_updated").innerHTML = "Last Updated at: " + data.updated_at.split("T")[0];
  }

  _removeDataOfEelements() {
    ["title", "description", "price", "mobile_number", "last_updated"].forEach((id) => {
      document.getElementById(id).innerHTML = "";
    });
  }

  _enableLoader() {
    document.getElementById("loader").innerHTML = "Loading....";
  }

  _disableLoader() {
    document.getElementById("loader").innerHTML = "";
  }

  _validateUrl() {
    const url = this.url;
    if((url == "" || url == " ") || !this.regex.test(url)) { return false; }
    return true;
  }
};

window.addEventListener('load', () => {
  const urlInputField = document.querySelector('#url-input');
  new ProductControls(urlInputField);
});
