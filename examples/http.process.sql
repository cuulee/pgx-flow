-- INSERT INTO flow.input (process, data) VALUES ('http.process', '{"url":"http://httpbin.org/get"}');
SET search_path TO flow, public;
BEGIN TRANSACTION;
DO $$
  BEGIN

    INSERT INTO process (uri, description) VALUES
      ('http.example', 'a sequential process with one asynchronous http activity');

    INSERT INTO activity (process, name, func, description, config) VALUES
      ('http.example', 'start', 'log', 'log start', '{"level":"INFO","message":"start HTTP example process"}'),
      ('http.example', 'get', 'http', 'GET HTTP', '{"method":"get"}'),
      ('http.example', 'end', 'log', 'log end', '{"level":"INFO","message":"end HTTP example process"}');

    INSERT INTO flow (process, source, target, description) VALUES
      ('http.example', 'start', 'get', 'start to http'),
      ('http.example', 'get', 'end', 'http to end');
  END;
$$;
COMMIT;
