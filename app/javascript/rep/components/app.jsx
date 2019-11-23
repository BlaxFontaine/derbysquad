import React, { Component } from 'react';
import GoogleMapReact from 'google-map-react';
import leagues from '../index.jsx'

import LeagueList from './league_list';
import Marker from './marker';


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
        <LeagueList
          leagues={this.state.leagues}
          selectedLeague={this.state.selectedLeague}
          selectLeague={this.selectLeague}
        />
        <div className="map-container">
          <GoogleMapReact center={this.center()} defaultZoom={5}>
            <Marker lat={this.state.selectedLeague.lat} lng={this.state.selectedLeague.lng} />
          </GoogleMapReact>
        </div>
      </div>
    );
  }
}

export default App;
