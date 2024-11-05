package com.ict.sns.vo;

import java.util.List;

public class RouteInfoVO {
	private List<RouteVO> routes;
	
	public class RouteVO{
		private List<SectionVO> sections;
		
		public class SectionVO{
			private int distance;
			private int duration;
			private List<RoadVO> roads;
			
			public class RoadVO{
				private String name;
				private int distance;
				private int duration;
				private double[] vertexes;
				public String getName() {
					return name;
				}
				public void setName(String name) {
					this.name = name;
				}
				public int getDistance() {
					return distance;
				}
				public void setDistance(int distance) {
					this.distance = distance;
				}
				public int getDuration() {
					return duration;
				}
				public void setDuration(int duration) {
					this.duration = duration;
				}
				public double[] getVertexes() {
					return vertexes;
				}
				public void setVertexes(double[] vertexes) {
					this.vertexes = vertexes;
				}
				
				
			}

			public int getDistance() {
				return distance;
			}

			public void setDistance(int distance) {
				this.distance = distance;
			}

			public int getDuration() {
				return duration;
			}

			public void setDuration(int duration) {
				this.duration = duration;
			}

			public List<RoadVO> getRoads() {
				return roads;
			}

			public void setRoads(List<RoadVO> roads) {
				this.roads = roads;
			}
			
			
		}

		public List<SectionVO> getSections() {
			return sections;
		}

		public void setSections(List<SectionVO> sections) {
			this.sections = sections;
		}
		
	}

	public List<RouteVO> getRoutes() {
		return routes;
	}

	public void setRoutes(List<RouteVO> routes) {
		this.routes = routes;
	}
	
}
