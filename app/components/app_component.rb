class AppComponent < ReflexComponent
  include ViewComponentReflex::WithRouter

  layout Dashboard::LayoutComponent

  routes '/properties' => Properties::IndexComponent,
         '/' => Properties::IndexComponent
end
