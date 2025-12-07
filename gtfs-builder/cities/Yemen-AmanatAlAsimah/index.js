const { osmToGtfs, OSMPBFReader, OSMOverpassDownloader } = require('trufi-gtfs-builder')
const path = require('path')
// -44.099927,15.248571,44.409375,15.622752
osmToGtfs({
  outputFiles: { outputDir: __dirname + '/out', trufiTPData: true, gtfs: true },
  geojsonOptions: {
    osmDataGetter: new OSMPBFReader(path.join(__dirname, "Yemen-AmanatAlAsimah.osm.pbf")),
    
    // osmDataGetter: new OSMOverpassDownloader({
    //   west: 44.12062,
    //   south: 15.27553,
    //   east: 44.39967,
    //   north: 15.61171
    // }),
  },
  gtfsOptions: {
    stopNameBuilder: stops => {
      if (!stops || stops.length == 0) {
        // stops = ['innominada']
        stops = ['‎']
      }
      // return stops.join(' y ')
      return stops.join(' ')
    },
  }
}).catch(error => console.error(error))
