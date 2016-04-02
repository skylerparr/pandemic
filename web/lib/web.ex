defmodule Web do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    #Node.start(:"mynode@#{NetHelper.get_ip_address}")
    host = System.get_env("CITY")
    Node.start(:"#{host}@#{NetHelper.get_ip_address}")
    Node.connect(:"#{System.get_env("MASTER")}")
    #Node.stop
    city = :rpc.call(:"#{System.get_env("MASTER")}", CityServer, :get_city_by_host, [host]) 
    #Node.start(:"#{host}@#{NetHelper.get_ip_address}")
    #Node.connect(:"#{System.get_env("MASTER")}")

    ServerUtil.start_link
    ServerUtil.set_hostname(host)
    ServerUtil.set_city(city)

    children = [
      # Start the endpoint when the application starts
      supervisor(Web.Endpoint, []),
      # Start the Ecto repository
      supervisor(Web.Repo, []),
      supervisor(DiseaseServer, []),
      #supervisor(ServerUtil, []),
      # Here you could define other workers and supervisors as children
      # worker(Web.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Web.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Web.Endpoint.config_change(changed, removed)
    :ok
  end
end