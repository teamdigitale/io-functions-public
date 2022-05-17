import * as express from "express";
import { wrapRequestHandler } from "io-functions-commons/dist/src/utils/request_middleware";
import {
  IResponseErrorInternal,
  IResponseSuccessJson,
  ResponseErrorInternal,
  ResponseSuccessJson
} from "italia-ts-commons/lib/responses";
import * as packageJson from "../package.json";
import { checkApplicationHealth, HealthCheck } from "../utils/healthcheck";

interface IInfo {
  // eslint-disable-next-line functional/prefer-readonly-type
  name: string;
  // eslint-disable-next-line functional/prefer-readonly-type
  version: string;
}

type InfoHandler = () => Promise<
  IResponseSuccessJson<IInfo> | IResponseErrorInternal
>;

// eslint-disable-next-line prefer-arrow/prefer-arrow-functions
export function InfoHandler(healthCheck: HealthCheck): InfoHandler {
  return () =>
    healthCheck
      .fold<IResponseSuccessJson<IInfo> | IResponseErrorInternal>(
        problems => ResponseErrorInternal(problems.join("\n\n")),
        _ =>
          ResponseSuccessJson({
            name: packageJson.name,
            version: packageJson.version
          })
      )
      .run();
}

// eslint-disable-next-line prefer-arrow/prefer-arrow-functions
export function Info(): express.RequestHandler {
  const handler = InfoHandler(checkApplicationHealth());

  return wrapRequestHandler(handler);
}
