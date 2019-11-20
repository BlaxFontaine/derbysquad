import React, { Component } from 'react';
import GoogleMapReact from 'google-map-react';

import flats from '../../data/flats';
import LeagueList from './league_list';
import Marker from './marker';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedLeague: flats[0],
      flats
    };
  }

  center() {
    return {
      lat: this.state.selectedLeague.lat,
      lng: this.state.selectedLeague.lng
    };
  }

  selectFlat = (id) => {
    this.setState({ selectedLeague: flats[id] });
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
          <GoogleMapReact defaultCenter={this.center()} defaultZoom={12}>
            <Marker lat={this.state.selectedLeague.lat} lng={this.state.selectedLeague.lng} />
          </GoogleMapReact>
        </div>
      </div>
    );
  }
}

export default App;
