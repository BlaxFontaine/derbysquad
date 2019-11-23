import React from 'react';
import ReactDOM from 'react-dom';

// internal modules
import '../../assets/stylesheets/application.scss';
import App from './components/app';

const root = document.getElementById("root");
const data = { leagues: JSON.parse(root.dataset.leagues) };
const leagues = data.leagues;
// render an instance of the component in the DOM

export default leagues;

ReactDOM.render(<App />, document.querySelector('#root'));

