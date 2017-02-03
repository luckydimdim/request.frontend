import 'dart:html';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

@Component(
    selector: 'request-document-list',
    templateUrl: 'request_document_list_component.html',
    directives: const [RouterLink])
class RequestDocumentListComponent implements OnInit {
  static const String route_name = 'RequestDocumentList';
  static const String route_path = 'document-list';
  static const Route route = const Route(
      path: RequestDocumentListComponent.route_path,
      component: RequestDocumentListComponent,
      name: RequestDocumentListComponent.route_name);

  final Router _router;
  final RouteParams _routeParams;

  RequestDocumentListComponent(this._router, this._routeParams) {}

  @override
  void ngOnInit() {
    breadcrumbInit();
  }

  void breadcrumbInit(){
    var  breadcrumbContent = querySelector('#breadcrumbContent') as DivElement;

    if (breadcrumbContent == null)
      return;

    breadcrumbContent.innerHtml = '''
            <li class="breadcrumb-item"><a href="#/master/dashboard">Главная</a></li>
            <li class="breadcrumb-item"><a href="#/master/requestList">Список заявок</a></li>
            <li class="breadcrumb-item"><a href="#/master/request">Создание заявки</a></li>
            <li class="breadcrumb-item"><a href="#/master/request/settings">Работы и материалы</a></li>
            <li class="breadcrumb-item active">Первичная документация</li>
    ''';
  }
}
