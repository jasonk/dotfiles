function pretty() { DBQuery.prototype._prettyShell = true; }
function ugly() { DBQuery.prototype._prettyShell = false; }

// change the prompt
host = db.serverStatus().host;
prompt = function() { return db + '@' + host + '$'; };
// DBQuery is the mongo shell's cursor object, so you can chain these
// methods of off any cursor.
Object.assign( DBQuery.prototype, {
  // Pretty-print by default, ugly by command
  _prettyShell : true,
  ugly() { this._prettyShell = false; return this; },
} );

// DBCollection is what you get from `db.whatever`.  Things added here
// get added in the same way as things like `find` and `insert`.
Object.assign( DBCollection.prototype, {
  getAllFieldNames() {
    return db[ this._shortName ].aggregate( [
      { $project : { x : { $objectToArray : "$$ROOT" } } },
      { $unwind : "$x" },
      { $group : { _id : null, keys : { $addToSet : "$x.k" } } },
    ] ).toArray()[0].keys.sort();
  },
} );

// control batch size (how many are shown before you have to type `it`)
DBQuery.shellBatchSize = 50;

function stringy( val ) {
  if ( typeof val === 'undefined' ) return '';
  if ( typeof val === 'string' ) return val;
  if ( Array.isArray( val ) ) return val.map( stringy ).join( ',' );
  return String( val );
}
function csvrow( arr ) {
  return JSON.stringify( arr.map( stringy ) ).slice( 1, -1 );
}
function printcsv( arr ) { print( csvrow( arr ) ); }

DBQuery.prototype.toCSV = DBCommandCursor.prototype.toCSV = Array.prototype.toCSV = toCSV;
function toCSV( opts={} ) {
  const { columns = [], headers = true } = opts;

  let idx = 0;
  this.forEach( ( rec ) => {
    if ( ! idx++ ) {
      if ( ! columns.length ) columns.push( ...Object.keys( rec ) );
      if ( headers === true ) printcsv( columns );
      if ( Array.isArray( headers ) ) printcsv( headers );
    }
    printcsv( columns.map( c => rec[ c ] ) );
  } );
}

DBQuery.prototype.stats = DBCommandCursor.prototype.stats = Array.prototype.stats = stats;
function stats( array ) {
  const mean = array.reduce((a, b) => a + b) / array.length;
  const stddev = ( population = false ) => Math.sqrt(
    array
      .reduce( (acc, val) => acc.concat((val - mean) ** 2), [] )
      .reduce((acc, val) => acc + val, 0) /
      (arr.length - (population ? 0 : 1))
  );
  return {
    min : Math.min( array ),
    max : Math.max( array ),
    mean,
    stddev_s : stddev( false ),
    stddev_p : stddev( true ),
  };
}
