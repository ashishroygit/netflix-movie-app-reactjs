import { Client, TablesDB, ID, Query } from 'appwrite';

const DATABASE_ID = import.meta.env.VITE_APPWRITE_DATABASE_ID;
const TABLE_ID = import.meta.env.VITE_APPWRITE_TABLE_ID;
const PROJECT_ID = import.meta.env.VITE_APPWRITE_PROJECT_ID;

const client = new Client()
  .setEndpoint('https://nyc.cloud.appwrite.io/v1') // Your API Endpoint
  .setProject(PROJECT_ID); // Your project ID

const tablesDB = new TablesDB(client);

export const updateSearchCount = async (searchTerm, movie) => {
  // 1. Use Appwrite SDK to search if the search term already exists in the database
  try {
    const result = await tablesDB.listRows({
      databaseId: DATABASE_ID,
      tableId: TABLE_ID,
      //  CORRECTED: Query.equal now uses an array as per documentation
      queries: [Query.equal('searchTerm', [searchTerm])]  // <-- corrected here
    }); //  CORRECTED: closed the object and parenthesis correctly

    if (result.rows.length > 0) {
      const row = result.rows[0];

      await tablesDB.updateRow({
        databaseId: DATABASE_ID,
        tableId: TABLE_ID,
        rowId: row.$id,
        data: { count: row.count + 1 }  
      });
    } else {
      //  CORRECTED: removed stray dot after 'await'
      await tablesDB.createRow({  // <-- corrected here
        databaseId: DATABASE_ID,
        tableId: TABLE_ID,
        rowId: ID.unique(),
        data: {
          searchTerm: searchTerm,
          count: 1,
          movie_id: movie.id,
          poster_url: `https://image.tmdb.org/t/p/w500${movie.poster_path}`
        }
      });
    }
  } catch (error) {
    console.error('Error updating search count:', error);
  }
  // 2. If it exists, increment the count by 1
  // 3. If it does not exist, create a new record with count set to 1
};

export const getTrendingMovies = async () => {
  try {
    const result = await tablesDB.listRows(
      {
        databaseId: DATABASE_ID,
        tableId: TABLE_ID,
        queries: [Query.orderDesc('count'), Query.limit(5)]
      });

      return result.rows;

    } catch (error) {
      console.error('Error fetching trending movies:', error);
      return [];
    }
  }