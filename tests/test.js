var server   = require('../index'),
    chai     = require('../node_modules/chai'),
    chaiHTTP = require('../node_modules/chai-http'),
    should   = chai.should();

chai.use(chaiHTTP);

reqServer = process.env.HTTP_TEST_SERVER || server

describe('Basic routes tests', function() {

    it('GET to / should return 200', function(done){
        chai.request(reqServer)
        .get('/')
        .end(function(err, res) {
            res.should.have.status(200);
            done();
        })

    })

    it('GET to /heartbeat should return 200', function(done){
        chai.request(reqServer)
        .get('/heartbeat')
        .end(function(err, res) {
            res.should.have.status(200);
            done();
        })

    })
})