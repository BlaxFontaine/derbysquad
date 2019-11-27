import React, { Component } from 'react';

class League extends Component {
  handleClick = (e) => {
    this.props.selectLeague(this.props.league.id);
    e.preventDefault();
  }

  render() {
    return (
      <div className={`card-product${this.props.selected ? ' active' : ''}`}>
          <img src={this.props.url.concat(this.props.league.logo)} />
          <div className="card-product-infos">
            <h2>{this.props.league.name}</h2>
            <p>{this.props.league.city}, {this.props.league.country}</p>
          </div>
          <a className="card-link" href="#" onClick={this.handleClick}></a>
      </div>
    );
  }
}

export default League;
