import 'dart:core';

import 'package:angular2/platform/browser.dart';
import 'package:angular2/core.dart';
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';

import 'package:request/request_settings_component.dart';
import 'package:request/src/cc2/request_cc2_component.dart';
import 'package:request/src/cc3/request_cc3_component.dart';
import 'package:request/src/documents/request_documents_component.dart';
import 'package:request/src/ts/request_ts_component.dart';
import 'package:resources_loader/resources_loader.dart';
import 'package:master_layout/master_layout_component.dart';

import 'package:request/request_component.dart';

bool get isDebug =>
    (const String.fromEnvironment('PRODUCTION', defaultValue: 'false')) !=
    'true';

@Component(selector: 'app')
@View(
  template: '<master-layout><request></request></master-layout>',
  directives: const [MasterLayoutComponent, RequestComponent])
@RouteConfig(const [
  RequestSettingsComponent.route,
  RequestCc2Component.route,
  RequestCc3Component.route,
  RequestTsComponent.route,
  RequestDocumentsComponent.route])
class AppComponent {}

main() async {
  if (isDebug) {
    reflector.trackUsage();
  }

  ComponentRef ref = await bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    const Provider(ResourcesLoaderService)
  ]);

  if (isDebug) {
    print('Application in DebugMode');
    enableDebugTools(ref);
    print('Unused keys: ${reflector.listUnusedKeys()}');
  }
}


