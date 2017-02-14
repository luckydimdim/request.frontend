import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'settings/request_settings_component.dart';
import 'cc2/request_cc2_component.dart';
import 'cc3/request_cc3_component.dart';
import 'ts/request_ts_component.dart';
import 'documents/request_documents_component.dart';

@Component(
    selector: 'request',
    templateUrl: 'request_component.html',
    directives: const [RouterLink, RouterOutlet])
@RouteConfig(const [
  RequestSettingsComponent.route,
  RequestCc2Component.route,
  RequestCc3Component.route,
  RequestTsComponent.route,
  RequestDocumentsComponent.route])
class RequestComponent {
  static const String route_name = 'Request';
  static const String route_path = 'request/...';
  static const Route route = const Route(
      path: RequestComponent.route_path,
      component: RequestComponent,
      name: RequestComponent.route_name);
}
