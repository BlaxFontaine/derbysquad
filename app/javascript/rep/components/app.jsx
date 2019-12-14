import React, { Component } from 'react';
import GoogleMapReact from 'google-map-react';
import leagues from '../index.jsx'

import LeagueList from './league_list';
import Marker from './marker';
import Navbar from './navbar';


class App extends Component {

  constructor(props) {
    super(props);
    this.state = {
      selectedLeague: leagues[0],
      leagues
    };
  }

  center() {
    return {
      lat: this.state.selectedLeague.lat,
      lng: this.state.selectedLeague.lng
    };
  }

  selectLeague = (id) => {
    this.setState({ selectedLeague: leagues.find(x => x.id === id) });
  }

  render() {
    return (
      <div>
        <Navbar/>
        <div className="content">
          <LeagueList
            leagues={this.state.leagues}
            selectedLeague={this.state.selectedLeague}
            selectLeague={this.selectLeague}
          />
          <div className="map-container">
            <GoogleMapReact center={this.center()} defaultZoom={5}>
              {this.state.leagues.map(league => (
                <Marker lat={league.lat} lng={league.lng} key={league.id}/>
              ))}
              <Marker lat={this.state.selectedLeague.lat} lng={this.state.selectedLeague.lng} className="marker-active" />
            </GoogleMapReact>
          </div>
        </div>
      </div>
    );
  }
}

export default App;
