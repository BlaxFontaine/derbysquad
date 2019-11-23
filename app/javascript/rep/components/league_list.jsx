import React from 'react';
import League from './league';

const LeagueList = (props) => {
  const renderList = () => {
    return props.leagues.map((league, id) => {
      return (
        <League
          league={league}
          key={league.id}
          selected={league.name === props.selectedLeague.name}
          id={id}
          selectLeague={props.selectLeague}
        />
      );
    });
  };

  return (
    <div className="league-list">
      {renderList()}
    </div>
  );
};

export default LeagueList;
