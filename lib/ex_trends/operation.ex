defmodule ExTrends.Operation do
  @moduledoc """
  Provides a default implementation for ExTrends functions.
  """

  @type query :: %{
          required(:keyword) => binary | list(binary),
          optional(:time) => binary,
          optional(:geo) => binary,
          optional(:hl) => binary,
          optional(:tz) => binary,
          optional(:prop) => binary,
          optional(:cat) => integer
        }

  @type query_with_resolution :: %{
          required(:keyword) => binary | list(binary),
          optional(:time) => binary,
          optional(:geo) => binary,
          optional(:resolution) => binary,
          optional(:hl) => binary,
          optional(:tz) => binary,
          optional(:prop) => binary,
          optional(:cat) => integer
        }

  @callback categories(hl :: binary) :: {:ok, term} | {:error, term}
  @callback categories!(hl :: binary) :: term | no_return

  @callback daily_trends(geo :: binary, hl :: binary, tz :: binary, ns :: binary) ::
              {:ok, term} | {:error, term}
  @callback daily_trends!(geo :: binary, hl :: binary, tz :: binary, ns :: binary) ::
              term | no_return

  @callback explore(req :: map) :: {:ok, term} | {:error, term}
  @callback explore!(req :: map) :: term | no_return

  @callback interest_by_region(query_with_resolution) :: {:ok, term} | {:error, term}
  @callback interest_by_region!(query_with_resolution) :: term | no_return

  @callback interest_over_time(query) :: {:ok, term} | {:error, term}
  @callback interest_over_time!(query) :: term | no_return

  @callback related_queries(query) :: {:ok, term} | {:error, term}
  @callback related_queries!(query) :: term | no_return

  @callback related_topics(query) :: {:ok, term} | {:error, term}
  @callback related_topics!(query) :: term | no_return

  @callback suggestions(query) :: {:ok, term} | {:error, term}
  @callback suggestions!(query) :: term | no_return

  @callback top_charts(date :: binary, geo :: binary, hl :: binary, tz :: binary) ::
              {:ok, term} | {:error, term}
  @callback top_charts!(date :: binary, geo :: binary, hl :: binary, tz :: binary) ::
              term | no_return

  # defmacro __using__(_) do
  #   quote do
  #     @behaviour ExTrends.Operation

  #     @doc """
  #     Starts ExTrends and its dependencies.
  #     """
  #     def start, do: :application.ensure_all_started(:ex_trends)

  #   end
  # end
end
