import React from 'react';
import searchIcon from '../assets/Search.svg';

const Search = ({searchTerm, setSearchTerm}) => {
  return (
    <div className="search">
      <div>
        <img src={searchIcon} alt="Search Icon" />
        <input
        type = "text"
        placeholder="Search Through Thousands of Movies"
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        />
      </div>
    </div>  
  )
}

export default Search;