import 'package:flutter/material.dart';

// --- MOCK DATA MODELS ---
// (Giữ nguyên các model StationReview, ChargingStationDetail, NearbyStation như bạn đã cung cấp)
class StationReview {
  final String userName;
  final String userImageUrl; // URL hoặc asset path
  final double rating;
  final String comment;
  final String timeAgo;

  StationReview({
    required this.userName,
    required this.userImageUrl,
    required this.rating,
    required this.comment,
    required this.timeAgo,
  });
}

class ChargingStationDetail {
  final String id;
  final String name;
  final String address;
  final List<String> imageUrls; // Danh sách URL hình ảnh cho carousel hoặc một ảnh
  final double averageRating;
  final int totalReviews;
  final String owner;
  final String typeOfCharge; // Ví dụ: "60KW | 150KW"
  final String parkingFee; // Ví dụ: "No", "Yes - 10.000 VND"
  final String detailDescription;
  final Map<int, int> ratingDistribution; // Ví dụ: {5: 30, 4: 15, 3: 5, 2: 1, 1: 1} (số sao: số lượt đánh giá)
  final List<StationReview> reviews;
  final List<NearbyStation> nearbyStations;

  ChargingStationDetail({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrls,
    required this.averageRating,
    required this.totalReviews,
    required this.owner,
    required this.typeOfCharge,
    required this.parkingFee,
    required this.detailDescription,
    required this.ratingDistribution,
    required this.reviews,
    required this.nearbyStations,
  });
}

class NearbyStation {
  final String id;
  final String name;
  final String distance; // Ví dụ: "4.55 km"
  final String address;

  NearbyStation({
    required this.id,
    required this.name,
    required this.distance,
    required this.address,
  });
}

// --- STATION DETAIL PAGE WIDGET ---

class StationDetailPage extends StatelessWidget {
  // Trường station vẫn là final và non-nullable
  final ChargingStationDetail station;

  // Dữ liệu mẫu để chạy thử trang này (vẫn là static)
  static ChargingStationDetail getSampleStation() {
    return ChargingStationDetail(
      id: "vinfast2_sample", // Đổi ID để phân biệt với trạm thật nếu cần
      name: "Trạm Sạc Vinfast 2 ",
      address: "45 Tôn Đức Thắng, Tp Dĩ An, Bình Dương ",
      imageUrls: [
        "https://placehold.co/600x400/2E2E48/FFF?text=Sample+Station+1",
        "https://placehold.co/600x400/3E3E58/FFF?text=Sample+Station+2",
      ],
      averageRating: 4.0,
      totalReviews: 52,
      owner: "Vinfast ",
      typeOfCharge: "30KW | 60KW | 90KW | 120KW | 150KW",
      parkingFee: "No",
      detailDescription:
      "Đây là mô tả MẪU cho trạm sạc Vinfast 2. Trạm có nhiều cổng sạc nhanh, hỗ trợ nhiều loại xe. Không gian rộng rãi, có mái che và gần các tiện ích công cộng. Hoạt động 24/7.",
      ratingDistribution: {5: 30, 4: 15, 3: 5, 2: 1, 1: 1},
      reviews: [
        StationReview(userName: "Courtney Henry ", userImageUrl: "https://placehold.co/100x100/777/FFF?text=CH", rating: 5, comment: "This is great! (Sample)", timeAgo: "2 hours ago"),
        StationReview(userName: "Cameron Williamson ", userImageUrl: "https://placehold.co/100x100/888/FFF?text=CW", rating: 4, comment: "Near my company. (Sample)", timeAgo: "3 hours ago"),
        StationReview(userName: "Jane Cooper ", userImageUrl: "https://placehold.co/100x100/999/FFF?text=JC", rating: 3, comment: "No coffee. (Sample)", timeAgo: "5 hours ago"),
      ],
      nearbyStations: [
        NearbyStation(id: "vf2_near1_sample", name: "Trạm sạc Vinfast 2 ", distance: "4.55 km", address: "1 Đa Tốn, Gia Lâm, Hà Nội"),
        NearbyStation(id: "vf2_near2_sample", name: "Trạm sạc Vinfast 3 ", distance: "9.32 km", address: "27 Cổ Linh, Long Biên, Hà Nội"),
      ],
    );
  }

  // THAY ĐỔI CONSTRUCTOR:
  // Tham số stationInput giờ là nullable
  // stationInput?.name.isEmpty là một ví dụ kiểm tra, bạn có thể dùng stationInput?.id.isEmpty
  // hoặc các điều kiện khác để xác định dữ liệu không hợp lệ.
  // Vì `name` trong ChargingStationDetail là `required final String name`, nó không thể null,
  // nhưng nó có thể là chuỗi rỗng. Nếu `id` có thể null hoặc rỗng, đó cũng là một điều kiện tốt.
  StationDetailPage({Key? key, ChargingStationDetail? stationInput})
      : station = (stationInput == null || stationInput.name.trim().isEmpty) // Kiểm tra nếu stationInput null hoặc tên rỗng
      ? StationDetailPage.getSampleStation() // Nếu không hợp lệ, dùng dữ liệu mẫu
      : stationInput, // Ngược lại, dùng dữ liệu được truyền vào
        super(key: key);


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: screenWidth * 0.6,
            floating: false,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: station.imageUrls.isNotEmpty
                  ? Image.network(
                station.imageUrls.first,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[800], child: const Icon(Icons.image_not_supported, color: Colors.white54, size: 50)),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                      color: Colors.grey[800],
                      child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary))));
                },
              )
                  : Container(color: Colors.grey[800], child: const Icon(Icons.ev_station, color: Colors.white54, size: 80)),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildHeaderSection(context, theme),
                _buildInfoSection(context, theme),
                _buildDetailTextSection(context, theme),
                _buildRatingSection(context, theme),
                _buildUserReviewsSection(context, theme),
                _buildNearStationsSection(context, theme),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: _buildWriteReviewButton(context, theme),
    );
  }

  // --- CÁC HÀM _build... GIỮ NGUYÊN NHƯ TRƯỚC ---
  // Chúng sẽ tự động sử dụng this.station (đã được gán giá trị đúng trong constructor)

  Widget _buildHeaderSection(BuildContext context, ThemeData theme) {
    return Container(
      color: const Color(0xFF1F1F2D),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            station.name, // Sử dụng this.station
            style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            station.address, // Sử dụng this.station
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                "Review",
                style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                station.averageRating.toStringAsFixed(1), // Sử dụng this.station
                style: theme.textTheme.titleMedium?.copyWith(color: Colors.amber, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              _buildStarRating(station.averageRating, color: Colors.amber, size: 20), // Sử dụng this.station
              const SizedBox(width: 8),
              Text(
                "(${station.totalReviews} reviews)", // Sử dụng this.station
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow("Owner", station.owner, theme),
          _buildInfoRow("Type of charge", station.typeOfCharge, theme),
          _buildInfoRow("Parking fee", station.parkingFee, theme),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[400]),
          ),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailTextSection(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail",
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            station.detailDescription, // Sử dụng this.station
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[300], height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection(BuildContext context, ThemeData theme) {
    int totalDistribution = station.ratingDistribution.values.fold(0, (prev, element) => prev + element);
    if (totalDistribution == 0) totalDistribution = 1;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rating",
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(5, (index) {
                    int star = 5 - index;
                    int count = station.ratingDistribution[star] ?? 0; // Sử dụng this.station
                    double percentage = count / totalDistribution;
                    return _buildRatingBar(star, percentage, theme);
                  }).reversed.toList(),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      station.averageRating.toStringAsFixed(1), // Sử dụng this.station
                      style: theme.textTheme.displaySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    _buildStarRating(station.averageRating, color: Colors.amber, size: 20), // Sử dụng this.station
                    const SizedBox(height: 4),
                    Text(
                      "${station.totalReviews} Reviews", // Sử dụng this.station
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int star, double percentage, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Text("$star", style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[400])),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.amber, size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[700],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating(double rating, {Color color = Colors.amber, double size = 16.0}) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.5;

    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(Icon(Icons.star, color: color, size: size));
      } else if (i == fullStars && halfStar) {
        stars.add(Icon(Icons.star_half, color: color, size: size));
      } else {
        stars.add(Icon(Icons.star_border, color: color, size: size));
      }
    }
    return Row(mainAxisSize: MainAxisSize.min, children: stars);
  }

  Widget _buildUserReviewsSection(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: station.reviews.length, // Sử dụng this.station
            itemBuilder: (context, index) {
              final review = station.reviews[index]; // Sử dụng this.station
              return _buildReviewItem(review, theme);
            },
            separatorBuilder: (context, index) => const Divider(color: Color(0xFF2A2A3A), height: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(StationReview review, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(review.userImageUrl),
              onBackgroundImageError: (exception, stackTrace) {},
              backgroundColor: Colors.grey[700],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.userName,
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      _buildStarRating(review.rating, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        review.timeAgo,
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.grey[500]),
              onPressed: () {},
            )
          ],
        ),
        const SizedBox(height: 12),
        Text(
          review.comment,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[300]),
        ),
      ],
    );
  }

  Widget _buildNearStationsSection(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Near Station",
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: station.nearbyStations.length, // Sử dụng this.station
            itemBuilder: (context, index) {
              final nearStation = station.nearbyStations[index]; // Sử dụng this.station
              bool isHighlighted = index == 0;
              return Card(
                elevation: 0,
                color: isHighlighted ? const Color(0xFF2A3C24) : const Color(0xFF2A2A3A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  title: Text(
                    nearStation.name,
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    "${nearStation.distance} | ${nearStation.address}",
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    print("Tapped on near station: ${nearStation.name}");
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWriteReviewButton(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color: theme.scaffoldBackgroundColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () {
          print("Write review button pressed");
        },
        child: Text(
          "Write review",
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
