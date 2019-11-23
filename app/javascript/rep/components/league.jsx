import React, { Component } from 'react';

class League extends Component {
  handleClick = () => {
    this.props.selectLeague(this.props.league.id);
  }

  render() {
    return (
      <div className={`card${this.props.selected ? ' active' : ''}`} style={{ backgroundImage: `linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.2)), url('${this.props.league.logo}')` }}>
        <div className="card-category">{this.props.league.country} {this.props.league.city}</div>
        <div className="card-description">
          <img src={this.props.url.concat(this.props.league.logo)} />
          <h2>{this.props.league.name}</h2>
        </div>
        <a className="card-link" href="#" onClick={this.handleClick}></a>
      </div>
    );
  }
}

export default League;
